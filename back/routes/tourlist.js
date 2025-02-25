const express = require('express');
const router = express.Router();

module.exports = (db) => {
  // Promise wrapper for database connection
  const promiseDb = db.promise();

  // Save tour data
  router.post('/save', async (req, res) => {
    const { companyId, tours, bolgeler, regions } = req.body;

    try {
      await promiseDb.beginTransaction();

      // Önce mevcut verileri temizle
      await promiseDb.query('DELETE FROM create_areaslist WHERE company_id = ?', [companyId]);
      await promiseDb.query('DELETE FROM regionslist WHERE company_id = ?', [companyId]);
      await promiseDb.query('DELETE FROM areaslist WHERE company_id = ?', [companyId]);

      // Veri kontrolü
      if (!companyId) {
        throw new Error('Company ID is required');
      }

      // Check for duplicate tour names
      if (tours && tours.length > 0) {
        const tourNames = tours.map(tour => tour.name);
        const uniqueTourNames = new Set(tourNames);
        if (tourNames.length !== uniqueTourNames.size) {
          await promiseDb.rollback();
          return res.status(400).json({ error: 'Aynı isimde birden fazla tur eklenemez.' });
        }

        // Check for duplicate sub-tour names across all tours
        const allSubTourNames = new Set();
        for (const tour of tours) {
          if (tour.subTours && tour.subTours.length > 0) {
            for (const subTour of tour.subTours) {
              const subTourName = subTour.name.trim().toUpperCase();
              if (allSubTourNames.has(subTourName)) {
                await promiseDb.rollback();
                return res.status(400).json({ error: `"${subTourName}" isimli alt tur başka bir turda zaten mevcut. Alt turlar benzersiz olmalıdır.` });
              }
              allSubTourNames.add(subTourName);
            }
          }
        }
      }

      // Check for duplicate region names
      if (regions && regions.length > 0) {
        const regionNames = regions.map(region => region.name.trim().toUpperCase());
        const uniqueRegionNames = new Set(regionNames);
        if (regionNames.length !== uniqueRegionNames.size) {
          await promiseDb.rollback();
          return res.status(400).json({ error: 'Aynı isimde birden fazla bölge eklenemez.' });
        }

        // Check for duplicate area names across all regions
        const allAreaNames = new Set();
        for (const region of regions) {
          if (region.areas && region.areas.length > 0) {
            for (const area of region.areas) {
              const areaName = area.name.trim().toUpperCase();
              if (allAreaNames.has(areaName)) {
                await promiseDb.rollback();
                return res.status(400).json({ error: `"${areaName}" isimli alan başka bir bölgede zaten mevcut. Alanlar benzersiz olmalıdır.` });
              }
              allAreaNames.add(areaName);
            }
          }
        }
      }

      // Önce mevcut turları ve alt turları getir
      const [existingTours] = await promiseDb.query(
        'SELECT t.id, t.name, st.id as sub_tour_id, st.name as sub_tour_name ' +
        'FROM tourlist t ' +
        'LEFT JOIN sub_tours st ON t.id = st.tour_id ' +
        'WHERE t.company_id = ?',
        [companyId]
      );

      // Mevcut turları map'e dönüştür
      const existingTourMap = new Map();
      existingTours.forEach(tour => {
        if (!existingTourMap.has(tour.id)) {
          existingTourMap.set(tour.id, {
            name: tour.name,
            subTours: new Map()
          });
        }
        if (tour.sub_tour_id) {
          existingTourMap.get(tour.id).subTours.set(tour.sub_tour_id, tour.sub_tour_name);
        }
      });

      // Insert tours and their sub-tours
      if (tours && tours.length > 0) {
        for (const tour of tours) {
          // Check if tour name exists in existing tours
          let existingTourId = null;
          for (const [id, existingTour] of existingTourMap.entries()) {
            if (existingTour.name === tour.name) {
              existingTourId = id;
              break;
            }
          }

          // Insert main tour
          const [tourResult] = await promiseDb.query(
            'INSERT INTO tourlist (name, company_id) VALUES (?, ?)',
            [tour.name, companyId]
          );

          const newTourId = tourResult.insertId;

          // Insert sub-tours if any
          if (tour.subTours && tour.subTours.length > 0) {
            for (const subTour of tour.subTours) {
              // Check if sub tour name exists in existing sub tours
              let existingSubTourName = null;
              if (existingTourId) {
                const existingSubTours = existingTourMap.get(existingTourId).subTours;
                for (const [, name] of existingSubTours) {
                  if (name === subTour.name) {
                    existingSubTourName = name;
                    break;
                  }
                }
              }

              await promiseDb.query(
                'INSERT INTO sub_tours (name, tour_id, company_id) VALUES (?, ?, ?)',
                [subTour.name, newTourId, companyId]
              );
            }
          }
        }
      }

      console.log('Gelen bolgeler:', bolgeler);
      // Insert bolgeler into create_areaslist
      if (bolgeler && bolgeler.length > 0) {
        const bolgeValues = bolgeler.map(bolge => [bolge.name, companyId]);
        console.log('Oluşturulan bolgeValues:', bolgeValues);
        try {
          await promiseDb.query(
            'INSERT INTO create_areaslist (name, company_id) VALUES ?',
            [bolgeValues]
          );
          console.log('Bölgeler başarıyla kaydedildi');
        } catch (error) {
          console.error('SQL Error:', error.message);
          console.error('SQL Query:', 'INSERT INTO create_areaslist (name, company_id) VALUES ?');
          console.error('Values:', bolgeValues);
          throw error;
        }
      }

      // Insert Bölgeler ve Alanlar
      if (regions && regions.length > 0) {
        for (const region of regions) {
          // Insert region
          const [regionResult] = await promiseDb.query(
            'INSERT INTO regionslist (name, company_id) VALUES (?, ?)',
            [region.name, companyId]
          );

          // Insert areas for this region
          if (region.areas && region.areas.length > 0) {
            const areaValues = region.areas.map(area => [
              area.name,
              regionResult.insertId,
              companyId
            ]);
            
            await promiseDb.query(
              'INSERT INTO areaslist (name, region_id, company_id) VALUES ?',
              [areaValues]
            );
          }
        }
      }

      await promiseDb.commit();
      
      res.json({
        success: true,
        message: 'Veriler başarıyla kaydedildi',
        savedData: {
          bolgeCount: bolgeler?.length || 0,
          regionCount: regions?.length || 0
        }
      });
    } catch (error) {
      await promiseDb.rollback();
      console.error('İşlem hatası:', error);
      res.status(500).json({ error: error.message });
    }
  });

  // GET - Şirkete ait tur verilerini getir
  router.get('/:companyId', async (req, res) => {
    console.log('GET request received for companyId:', req.params.companyId);
    
    try {
      const { companyId } = req.params;

      if (!companyId) {
        console.log('CompanyId is missing');
        return res.status(400).json({ error: 'Şirket ID gerekli' });
      }

      console.log('Executing database queries...');
      
      // Get tours with their sub-tours
      const [tours] = await promiseDb.query(
        'SELECT t.*, st.id as sub_tour_id, st.name as sub_tour_name ' +
        'FROM tourlist t ' +
        'LEFT JOIN sub_tours st ON t.id = st.tour_id ' +
        'WHERE t.company_id = ?',
        [companyId]
      );

      // Format tours with sub-tours
      const formattedTours = tours.reduce((acc, curr) => {
        const tour = acc.find(t => t.id === curr.id);
        if (!tour) {
          acc.push({
            id: curr.id,
            name: curr.name,
            subTours: curr.sub_tour_id ? [{
              id: curr.sub_tour_id,
              name: curr.sub_tour_name
            }] : []
          });
        } else if (curr.sub_tour_id && !tour.subTours.find(st => st.id === curr.sub_tour_id)) {
          tour.subTours.push({
            id: curr.sub_tour_id,
            name: curr.sub_tour_name
          });
        }
        return acc;
      }, []);

      // create_areaslist tablosundan bölgeleri getir
      const [bolgeler] = await promiseDb.query(
        'SELECT * FROM create_areaslist WHERE company_id = ?',
        [companyId]
      );

      // Bölgeler ve Alanlar listesini getir
      const [regions] = await promiseDb.query(
        'SELECT r.*, a.id as area_id, a.name as area_name ' +
        'FROM regionslist r ' +
        'LEFT JOIN areaslist a ON r.id = a.region_id ' +
        'WHERE r.company_id = ?',
        [companyId]
      );

      // Bölgeleri ve alanları düzenle
      const formattedRegions = regions.reduce((acc, curr) => {
        const region = acc.find(r => r.id === curr.id);
        if (!region) {
          acc.push({
            id: curr.id,
            name: curr.name,
            areas: curr.area_id ? [{
              id: curr.area_id,
              name: curr.area_name
            }] : []
          });
        } else if (curr.area_id && !region.areas.find(a => a.id === curr.area_id)) {
          region.areas.push({
            id: curr.area_id,
            name: curr.area_name
          });
        }
        return acc;
      }, []);

      // Verileri client'a gönder
      res.json({
        tours: formattedTours,
        bolgeler: bolgeler.map(bolge => ({
          id: bolge.id,
          name: bolge.name
        })),
        regions: formattedRegions
      });

    } catch (error) {
      console.error('Detailed error in GET /tourlist/:companyId:', error);
      res.status(500).json({ 
        error: 'Sunucu hatası',
        details: error.message,
        stack: process.env.NODE_ENV === 'development' ? error.stack : undefined
      });
    }
  });

  // Add new route for sub-tour operations
  router.post('/subtour', async (req, res) => {
    const { tourId, name, companyId } = req.body;

    try {
      const [result] = await promiseDb.query(
        'INSERT INTO sub_tours (name, tour_id, company_id) VALUES (?, ?, ?)',
        [name, tourId, companyId]
      );

      res.json({
        success: true,
        subTour: {
          id: result.insertId,
          name,
          tourId
        }
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });

  // Update tour or sub-tour name
  router.put('/update-name', async (req, res) => {
    const { companyId, tourId, subTourId, newName, oldName, type } = req.body;

    if (!companyId || !newName) {
      return res.status(400).json({ error: 'Required fields are missing' });
    }

    try {
      await promiseDb.beginTransaction();

      // Bölge veya alan güncellemesi
      if (type === 'region' || type === 'area' || type === 'tour_region') {
        if (type === 'region') {
          // Get the current region name
          const [currentRegion] = await promiseDb.query(
            'SELECT name FROM regionslist WHERE id = ? AND company_id = ?',
            [tourId, companyId]
          );

          if (currentRegion.length > 0) {
            const oldRegionName = currentRegion[0].name;

            // Update region name in regionslist table
            await promiseDb.query(
              'UPDATE regionslist SET name = ? WHERE id = ? AND company_id = ?',
              [newName, tourId, companyId]
            );

            // Update region in tour_pickup_times table
            await promiseDb.query(
              'UPDATE tour_pickup_times SET region = ? WHERE region = ? AND company_id = ?',
              [newName, oldRegionName, companyId]
            );
          }
        } else if (type === 'area') {
          // Get the current area name
          const [currentArea] = await promiseDb.query(
            'SELECT name FROM areaslist WHERE id = ? AND company_id = ?',
            [tourId, companyId]
          );

          if (currentArea.length > 0) {
            const oldAreaName = currentArea[0].name;

            // Update area name in areaslist table
            await promiseDb.query(
              'UPDATE areaslist SET name = ? WHERE id = ? AND company_id = ?',
              [newName, tourId, companyId]
            );

            // Update area in tour_pickup_times table
            await promiseDb.query(
              'UPDATE tour_pickup_times SET area = ? WHERE area = ? AND company_id = ?',
              [newName, oldAreaName, companyId]
            );
          }
        } else if (type === 'tour_region') {
          // Update in create_areaslist table
          await promiseDb.query(
            'UPDATE create_areaslist SET name = ? WHERE id = ? AND company_id = ?',
            [newName, tourId, companyId]
          );

          // Update in tour_regions table
          await promiseDb.query(
            'UPDATE tour_regions SET region_name = ? WHERE region_name = ? AND company_id = ?',
            [newName, oldName, companyId]
          );

          // Update in guide_regions table
          await promiseDb.query(
            'UPDATE guide_regions SET region_name = ? WHERE region_name = ? AND company_id = ?',
            [newName, oldName, companyId]
          );
        }
      }
      // Tur veya alt tur güncellemesi
      else if (subTourId) {
        // Check if sub-tour name already exists
        const [existingSubTour] = await promiseDb.query(
          'SELECT id FROM sub_tours WHERE name = ? AND company_id = ? AND id != ?',
          [newName, companyId, subTourId]
        );

        if (existingSubTour.length > 0) {
          return res.status(400).json({ 
            error: 'Bu isimde bir alt tur zaten mevcut. Lütfen farklı bir isim seçiniz.' 
          });
        }

        // Get the current sub-tour name
        const [currentSubTour] = await promiseDb.query(
          'SELECT name, tour_id FROM sub_tours WHERE id = ? AND company_id = ?',
          [subTourId, companyId]
        );

        if (currentSubTour.length > 0) {
          const oldSubTourName = currentSubTour[0].name;

          // Update sub-tour name in sub_tours table
          await promiseDb.query(
            'UPDATE sub_tours SET name = ? WHERE id = ? AND company_id = ?',
            [newName, subTourId, companyId]
          );

          // Update tour_name in tours table using the old sub-tour name
          await promiseDb.query(
            'UPDATE tours SET tour_name = ? WHERE tour_name = ? AND company_ref = ?',
            [newName, oldSubTourName, companyId]
          );
        }
      } else if (tourId) {
        // Check if tour name already exists
        const [existingTour] = await promiseDb.query(
          'SELECT id FROM tourlist WHERE name = ? AND company_id = ? AND id != ?',
          [newName, companyId, tourId]
        );

        if (existingTour.length > 0) {
          return res.status(400).json({ 
            error: 'Bu isimde bir tur zaten mevcut. Lütfen farklı bir isim seçiniz.' 
          });
        }

        // Get the current tour name from tourlist
        const [currentTour] = await promiseDb.query(
          'SELECT name FROM tourlist WHERE id = ? AND company_id = ?',
          [tourId, companyId]
        );

        if (currentTour.length > 0) {
          const oldTourName = currentTour[0].name;

          // Update tour name in tourlist table
          await promiseDb.query(
            'UPDATE tourlist SET name = ? WHERE id = ? AND company_id = ?',
            [newName, tourId, companyId]
          );

          // Update tour_name in main_tours table using the old tour name
          await promiseDb.query(
            'UPDATE main_tours SET tour_name = ? WHERE tour_name = ? AND company_ref = ?',
            [newName, oldTourName, companyId]
          );

          // Update all related tours in the tours table
          await promiseDb.query(
            'UPDATE tours SET tour_name = ? WHERE tour_name = ? AND company_ref = ?',
            [newName, oldTourName, companyId]
          );
        }
      }

      await promiseDb.commit();

      res.json({
        success: true,
        message: `${type} name updated successfully in all related tables`
      });

    } catch (error) {
      await promiseDb.rollback();
      console.error('Name update error:', error);
      res.status(500).json({ error: error.message });
    }
  });

  // Delete region or area
  router.delete('/:type/:id', async (req, res) => {
    const { type, id } = req.params;
    const { companyId } = req.query;

    if (!companyId || !id) {
      return res.status(400).json({ error: 'Required fields are missing' });
    }

    try {
      await promiseDb.beginTransaction();

      if (type === 'region') {
        // Get the current region name before deleting
        const [currentRegion] = await promiseDb.query(
          'SELECT name FROM regionslist WHERE id = ? AND company_id = ?',
          [id, companyId]
        );

        if (currentRegion.length > 0) {
          const regionName = currentRegion[0].name;

          // Delete region from regionslist
          await promiseDb.query(
            'DELETE FROM regionslist WHERE id = ? AND company_id = ?',
            [id, companyId]
          );

          // Set region to empty in tour_pickup_times
          await promiseDb.query(
            'UPDATE tour_pickup_times SET region = "", area = "" WHERE region = ? AND company_id = ?',
            [regionName, companyId]
          );
        }
      } else if (type === 'area') {
        // Get the current area name before deleting
        const [currentArea] = await promiseDb.query(
          'SELECT name FROM areaslist WHERE id = ? AND company_id = ?',
          [id, companyId]
        );

        if (currentArea.length > 0) {
          const areaName = currentArea[0].name;

          // Delete area from areaslist
          await promiseDb.query(
            'DELETE FROM areaslist WHERE id = ? AND company_id = ?',
            [id, companyId]
          );

          // Set area to empty in tour_pickup_times
          await promiseDb.query(
            'UPDATE tour_pickup_times SET area = "" WHERE area = ? AND company_id = ?',
            [areaName, companyId]
          );
        }
      }

      await promiseDb.commit();
      res.json({ success: true });
    } catch (error) {
      await promiseDb.rollback();
      console.error('Delete operation error:', error);
      res.status(500).json({ error: error.message });
    }
  });

  return router;
}; 