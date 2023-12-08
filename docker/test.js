import http from 'k6/http';

export default function () {
  const url = 'http://0.0.0.0:2525/v1/verify/tax';
  const payload = JSON.stringify({
    nik: '3302041508910001',
    nama: 'SITI MUNIFAH',
    npwp: '914586854036000',
    search_type: 'individual'
  });

  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };

  http.post(url, payload, params);
}

