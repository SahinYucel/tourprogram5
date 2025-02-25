const express = require('express');
const router = express.Router();
const https = require('https');
const xml2js = require('xml2js');

router.get('/', async (req, res) => {
  try {
    // TCMB'nin XML servisine HTTPS isteği
    const options = {
      hostname: 'www.tcmb.gov.tr',
      path: '/kurlar/today.xml',
      method: 'GET',
      headers: {
        'Accept': 'application/xml',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
      }
    };

    const request = https.request(options, (response) => {
      let data = '';

      response.on('data', (chunk) => {
        data += chunk;
      });

      response.on('end', async () => {
        try {
          const parser = new xml2js.Parser({ explicitArray: false });
          const result = await parser.parseStringPromise(data);
          
          if (!result || !result.Tarih_Date || !result.Tarih_Date.Currency) {
            throw new Error('Geçersiz XML yapısı');
          }

          // Currency'leri array olarak al
          const currencies = Array.isArray(result.Tarih_Date.Currency) 
            ? result.Tarih_Date.Currency 
            : [result.Tarih_Date.Currency];

          // TCMB'den gelen kurları işle
          const rates = {
            EUR: {
              buying: parseFloat(currencies.find(c => c.$.Kod === 'EUR')?.ForexBuying) || 0,
              selling: parseFloat(currencies.find(c => c.$.Kod === 'EUR')?.ForexSelling) || 0,
              code: 'EUR',
              name: 'Euro'
            },
            USD: {
              buying: parseFloat(currencies.find(c => c.$.Kod === 'USD')?.ForexBuying) || 0,
              selling: parseFloat(currencies.find(c => c.$.Kod === 'USD')?.ForexSelling) || 0,
              code: 'USD',
              name: 'ABD Doları'
            },
            GBP: {
              buying: parseFloat(currencies.find(c => c.$.Kod === 'GBP')?.ForexBuying) || 0,
              selling: parseFloat(currencies.find(c => c.$.Kod === 'GBP')?.ForexSelling) || 0,
              code: 'GBP',
              name: 'İngiliz Sterlini'
            },
            TRY: {
              buying: 1,
              selling: 1,
              code: 'TRY',
              name: 'Türk Lirası'
            }
          };

          // Kurların geçerli olup olmadığını kontrol et
          Object.keys(rates).forEach(key => {
            if ((key !== 'TRY' && rates[key].buying <= 0) || rates[key].selling <= 0) {
              console.error(`Geçersiz ${key} kuru:`, rates[key]);
              throw new Error(`${key} için geçersiz kur değeri`);
            }
          });

          res.json({
            success: true,
            data: rates,
            timestamp: new Date(),
            lastUpdateTime: new Date()
          });

        } catch (parseError) {
          console.error('XML parse hatası:', parseError);
          res.status(500).json({
            success: false,
            message: 'Kur verileri işlenirken hata oluştu',
            error: parseError.message
          });
        }
      });
    });

    request.on('error', (error) => {
      console.error('TCMB bağlantı hatası:', error);
      res.status(500).json({
        success: false,
        message: 'TCMB sunucusuna bağlanılamadı',
        error: error.message
      });
    });

    request.end();

  } catch (error) {
    console.error('Genel hata:', error);
    res.status(500).json({
      success: false,
      message: 'Kurlar güncellenirken bir hata oluştu',
      error: error.message
    });
  }
});

module.exports = router; 