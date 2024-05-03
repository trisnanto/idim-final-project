-- daftar Kecamatan di Kota Bandung
SELECT DISTINCT(bps_nama_kecamatan) kecamatan FROM kecamatan_luas;

-- jumlah PAUD di Kota Bandung pada semester 1 tahun pelajaran 2022/2023
SELECT COUNT(id) jumlah_paud FROM paud
WHERE semester_ajaran = '1' AND tahun_ajaran = '2022/2023';

-- jumlah PAUD Negeri dan Swasta di Kota Bandung pada semester 1 tahun pelajaran 2022/2023
SELECT status_sekolah, COUNT(id) jumlah FROM paud
WHERE semester_ajaran = '1' AND tahun_ajaran = '2022/2023'
GROUP BY status_sekolah;

-- jumlah PAUD per Kecamatan diurutkan dari terbanyak
SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah FROM paud
WHERE semester_ajaran = '1' AND tahun_ajaran = '2022/2023' 
GROUP BY bps_nama_kecamatan  ORDER BY jumlah DESC;

-- jumlah SD di Kota Bandung pada semester 1 tahun pelajaran 2022/2023
SELECT COUNT(id) jumlah FROM sd
WHERE semester = '1' AND tahun = '2022/2023';

-- jumlah SD Negeri dan Swasta di Kota Bandung pada semester 1 tahun pelajaran 2022/2023
SELECT status_sekolah, COUNT(id) jumlah_sd FROM sd
WHERE semester = '1' AND tahun = '2022/2023'
GROUP BY status_sekolah;

-- jumlah SD per Kecamatan diurutkan dari terbanyak
SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah FROM sd
WHERE semester = '1' AND tahun = '2022/2023' 
GROUP BY bps_nama_kecamatan  ORDER BY jumlah DESC;

-- jumlah SMP di Kota Bandung pada semester 1 tahun pelajaran 2022/2023
SELECT COUNT(id) jumlah_smp FROM smp
WHERE semester_ajaran = '1' AND tahun_ajaran = '2022/2023';

-- jumlah SMP Negeri dan Swasta di Kota Bandung pada semester 1 tahun pelajaran 2022/2023
SELECT status_sekolah, COUNT(id) jumlah_smp FROM smp
WHERE semester_ajaran = '1' AND tahun_ajaran = '2022/2023'
GROUP BY status_sekolah;

-- jumlah SMP per Kecamatan diurutkan dari terbanyak
SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah FROM smp
WHERE semester_ajaran ='1' AND tahun_ajaran = '2022/2023' 
GROUP BY bps_nama_kecamatan  ORDER BY jumlah DESC;

-- daftar PAUD per Kecamatan di Kota Bandung
SELECT DISTINCT(nama_kecamatan) kecamatan, paud.nama_sekolah FROM kecamatan_alamat
JOIN paud ON kecamatan_alamat.nama_kecamatan = paud.bps_nama_kecamatan 
ORDER BY nama_kecamatan;

-- daftar SD per Kecamatan di Kota Bandung
SELECT DISTINCT(nama_kecamatan) kecamatan, sd.nama_sekolah FROM kecamatan_alamat
JOIN sd ON kecamatan_alamat.nama_kecamatan = sd.bps_nama_kecamatan
ORDER BY nama_kecamatan;

-- daftar SMP per Kecamatan di Kota Bandung
SELECT DISTINCT(nama_kecamatan) kecamatan, smp.nama_sekolah FROM kecamatan_alamat
JOIN smp ON kecamatan_alamat.nama_kecamatan = smp.bps_nama_kecamatan
ORDER BY nama_kecamatan;

-- jumlah PAUD, SD, dan SMP per Kecamatan di Kota Bandung pada semester 1 tahun pelajaran 2022/2023 - versi join
SELECT DISTINCT(a.bps_nama_kecamatan) kecamatan, COALESCE(paud.jumlah,0) jumlah_paud, COALESCE(sd.jumlah,0) jumlah_sd, COALESCE(smp.jumlah,0) jumlah_smp
FROM jumlah_penduduk a LEFT JOIN
(SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah  FROM paud WHERE semester_ajaran ='1' AND tahun_ajaran = '2022/2023' GROUP BY bps_nama_kecamatan) paud
ON a.bps_nama_kecamatan = paud.kecamatan LEFT JOIN
(SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah FROM sd WHERE semester = '1' AND tahun = '2022/2023' GROUP BY bps_nama_kecamatan) sd
ON a.bps_nama_kecamatan = sd.kecamatan LEFT JOIN
(SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah FROM smp WHERE semester_ajaran ='1' AND tahun_ajaran = '2022/2023' GROUP BY bps_nama_kecamatan) smp
ON a.bps_nama_kecamatan = smp.kecamatan ORDER BY a.bps_nama_kecamatan;

-- jumlah PAUD, SD, dan SMP berdasarkan status sekolah di Kota Bandung pada semester 1 tahun pelajaran 2022/2023
SELECT paud.status_sekolah, paud.jumlah jumlah_paud, sd.jumlah jumlah_sd, smp.jumlah jumlah_smp FROM
(SELECT status_sekolah, COUNT(id) jumlah FROM paud
WHERE semester_ajaran = '1' AND tahun_ajaran = '2022/2023' GROUP BY status_sekolah) paud
LEFT JOIN
(SELECT status_sekolah, COUNT(id) jumlah FROM sd
WHERE semester = '1' AND tahun = '2022/2023' GROUP BY status_sekolah) sd
ON paud.status_sekolah = sd.status_sekolah
LEFT JOIN
(SELECT status_sekolah, COUNT(id) jumlah FROM smp
WHERE semester_ajaran = '1' AND tahun_ajaran = '2022/2023' GROUP BY status_sekolah) smp
ON paud.status_sekolah = smp.status_sekolah;

-- 10 Kecamatan dengan jumlah total sekolah (PAUD, SD, dan SMP) terbanyak di Kota Bandung pada semester 1 tahun ajaran 2022/2023
SELECT DISTINCT(a.bps_nama_kecamatan) kecamatan, COALESCE(paud.jumlah,0) jumlah_paud, COALESCE(sd.jumlah,0) jumlah_sd, COALESCE(smp.jumlah,0) jumlah_smp,
(COALESCE(paud.jumlah,0) + COALESCE(sd.jumlah,0) + COALESCE(smp.jumlah,0)) total
FROM jumlah_penduduk a LEFT JOIN
(SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah  FROM paud WHERE semester_ajaran ='1' AND tahun_ajaran = '2022/2023' GROUP BY bps_nama_kecamatan) paud
ON a.bps_nama_kecamatan = paud.kecamatan LEFT JOIN
(SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah FROM sd WHERE semester = '1' AND tahun = '2022/2023' GROUP BY bps_nama_kecamatan) sd
ON a.bps_nama_kecamatan = sd.kecamatan LEFT JOIN
(SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah FROM smp WHERE semester_ajaran ='1' AND tahun_ajaran = '2022/2023' GROUP BY bps_nama_kecamatan) smp
ON a.bps_nama_kecamatan = smp.kecamatan ORDER BY a.bps_nama_kecamatan, total LIMIT 10;

-- tingkat kepadatan penduduk (jiwa/km2) di setiap kecamatan di Kota Bandung
SELECT a.bps_nama_kecamatan kecamatan, a.luas_wilayah, b.jumlah_penduduk, ROUND(jumlah_penduduk/a.luas_wilayah) kepadatan FROM kecamatan_luas a 
JOIN 
(SELECT DISTINCT(bps_nama_kecamatan) kecamatan, SUM(jumlah_penduduk) jumlah_penduduk FROM jumlah_penduduk WHERE semester = '1' AND tahun = '2022'
GROUP BY bps_nama_kecamatan) b
ON a.bps_nama_kecamatan = kecamatan
ORDER BY kepadatan DESC

-- Jumlah sekolah (PAUD, SD, SMP) di setiap kecamatan di Kota Bandung diurutkan dari jumlah penduduk tertinggi pada semester 1 tahun 2022
SELECT a.bps_nama_kecamatan kecamatan, b.jumlah_penduduk, a.luas_wilayah, ROUND(jumlah_penduduk/a.luas_wilayah) kepadatan, COALESCE(paud.jumlah,0) jumlah_paud, COALESCE(sd.jumlah,0) jumlah_sd, COALESCE(smp.jumlah,0) jumlah_smp FROM kecamatan_luas a JOIN 
(SELECT DISTINCT(bps_nama_kecamatan) kecamatan, SUM(jumlah_penduduk) jumlah_penduduk FROM jumlah_penduduk WHERE semester = '1' AND tahun = '2022'
GROUP BY bps_nama_kecamatan) b ON a.bps_nama_kecamatan = kecamatan LEFT JOIN (SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah  FROM paud WHERE semester_ajaran ='1' AND tahun_ajaran = '2022/2023' GROUP BY bps_nama_kecamatan) paud ON a.bps_nama_kecamatan = paud.kecamatanLEFT JOIN (SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah FROM sd WHERE semester = '1' AND tahun = '2022/2023' GROUP BY bps_nama_kecamatan) sd
ON a.bps_nama_kecamatan = sd.kecamatan LEFT JOIN
(SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah FROM smp WHERE semester_ajaran ='1' AND tahun_ajaran = '2022/2023' GROUP BY bps_nama_kecamatan) smp
ON a.bps_nama_kecamatan = smp.kecamatan 
ORDER BY jumlah_penduduk DESC
