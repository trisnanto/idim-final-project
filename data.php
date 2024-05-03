<?php
  class Database {
    private $server ="127.0.0.1";
    private $username = "root";
    private $password = "g3m1l4ng";
    private $database = "finpro";

    function koneksidatabase() {
      try {
        // buat koneksi dengan database
        $dbh = new PDO('mysql:host='. $this->server.';dbname='. $this->database, $this->username, $this->password);
        // set error mode
        $dbh->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
        return $dbh;
      }
      catch (PDOException $e) {
        // tampilkan pesan kesalahan jika koneksi gagal
        print "Koneksi atau query bermasalah: " . $e->getMessage() . "<br/>";
        die();
      }
    }
  }

  function getData1() {
    try {
      $d1 = new Database();
      $db = $d1->koneksidatabase();
      $query = "SELECT status_sekolah, COUNT(id) jumlah FROM paud WHERE semester_ajaran = '1' AND tahun_ajaran = '2022/2023' GROUP BY status_sekolah";
      $prepareDB = $db->prepare($query);
      $prepareDB->execute();
      $data = $prepareDB->fetchAll();
      // echo json_encode($data);
      return $data;
    } catch (Exception $e) {
      throw $e;
    }
  }

  function getData2() {
    try {
      $d1 = new Database();
      $db = $d1->koneksidatabase();
      $query = "SELECT DISTINCT(a.bps_nama_kecamatan) kecamatan, COALESCE(paud.jumlah,0) jumlah_paud, COALESCE(sd.jumlah,0) jumlah_sd, COALESCE(smp.jumlah,0) jumlah_smp,
      (COALESCE(paud.jumlah,0) + COALESCE(sd.jumlah,0) + COALESCE(smp.jumlah,0)) total
      FROM jumlah_penduduk a LEFT JOIN
      (SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah  FROM paud WHERE semester_ajaran ='1' AND tahun_ajaran = '2022/2023' GROUP BY bps_nama_kecamatan) paud
      ON a.bps_nama_kecamatan = paud.kecamatan LEFT JOIN
      (SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah FROM sd WHERE semester = '1' AND tahun = '2022/2023' GROUP BY bps_nama_kecamatan) sd
      ON a.bps_nama_kecamatan = sd.kecamatan LEFT JOIN
      (SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah FROM smp WHERE semester_ajaran ='1' AND tahun_ajaran = '2022/2023' GROUP BY bps_nama_kecamatan) smp
      ON a.bps_nama_kecamatan = smp.kecamatan ORDER BY a.bps_nama_kecamatan, total LIMIT 10";
      $prepareDB = $db->prepare($query);
      $prepareDB->execute();
      $data = $prepareDB->fetchAll();
      // echo json_encode($data);
      return $data;
    } catch (Exception $e) {
      throw $e;
    }
  }

  function getData3() {
    try {
      $d1 = new Database();
      $db = $d1->koneksidatabase();
      $query = "SELECT a.bps_nama_kecamatan kecamatan, b.jumlah_penduduk, a.luas_wilayah, ROUND(jumlah_penduduk/a.luas_wilayah) kepadatan, COALESCE(paud.jumlah,0) jumlah_paud, COALESCE(sd.jumlah,0) jumlah_sd, COALESCE(smp.jumlah,0) jumlah_smp FROM kecamatan_luas a JOIN 
      (SELECT DISTINCT(bps_nama_kecamatan) kecamatan, SUM(jumlah_penduduk) jumlah_penduduk FROM jumlah_penduduk WHERE semester = '1' AND tahun = '2022'
      GROUP BY bps_nama_kecamatan) b ON a.bps_nama_kecamatan = kecamatan LEFT JOIN (SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah  FROM paud WHERE semester_ajaran ='1' AND tahun_ajaran = '2022/2023' GROUP BY bps_nama_kecamatan) paud ON a.bps_nama_kecamatan = paud.kecamatan LEFT JOIN (SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah FROM sd WHERE semester = '1' AND tahun = '2022/2023' GROUP BY bps_nama_kecamatan) sd
      ON a.bps_nama_kecamatan = sd.kecamatan LEFT JOIN
      (SELECT bps_nama_kecamatan kecamatan, COUNT(id) jumlah FROM smp WHERE semester_ajaran ='1' AND tahun_ajaran = '2022/2023' GROUP BY bps_nama_kecamatan) smp
      ON a.bps_nama_kecamatan = smp.kecamatan 
      ORDER BY jumlah_penduduk DESC";
      $prepareDB = $db->prepare($query);
      $prepareDB->execute();
      $data = $prepareDB->fetchAll();
      // echo json_encode($data);
      return $data;
    } catch (Exception $e) {
      throw $e;
    }
  }

  function getData5() {
    try {
      $d1 = new Database();
      $db = $d1->koneksidatabase();
      $query = "SELECT status_sekolah, COUNT(id) jumlah FROM sd
      WHERE semester = '1' AND tahun = '2022/2023'
      GROUP BY status_sekolah";
      $prepareDB = $db->prepare($query);
      $prepareDB->execute();
      $data = $prepareDB->fetchAll();
      // echo json_encode($data);
      return $data;
    } catch (Exception $e) {
      throw $e;
    }
  }

  function getData6() {
    try {
      $d1 = new Database();
      $db = $d1->koneksidatabase();
      $query = "SELECT status_sekolah, COUNT(id) jumlah FROM smp
      WHERE semester_ajaran = '1' AND tahun_ajaran = '2022/2023'
      GROUP BY status_sekolah";
      $prepareDB = $db->prepare($query);
      $prepareDB->execute();
      $data = $prepareDB->fetchAll();
      // echo json_encode($data);
      return $data;
    } catch (Exception $e) {
      throw $e;
    }
  }
  
  $data = array();
  $data[] = getData1();
  $data[] = getData2();
  $data[] = getData3();
  $data[] = getData5();
  $data[] = getData6();

  echo json_encode($data);
  exit();
?>