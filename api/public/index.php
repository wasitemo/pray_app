<?php
header("Content-Type: application/json");
require_once "../config/database.php";

function getCityByCoordinates($latitude, $longitude, $pdo) {
    $stmt = $pdo->query("SELECT nama, lat_min, lat_max, lon_min, lon_max FROM kota");
    $cities = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    foreach ($cities as $city) {
        if ($latitude >= $city['lat_min'] && $latitude <= $city['lat_max'] &&
            $longitude >= $city['lon_min'] && $longitude <= $city['lon_max']) {
            return $city['nama'];
        }
    }
    return null;
}

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    if (isset($_GET['latitude']) && isset($_GET['longitude']) && isset($_GET['tanggal'])) {
        $latitude = $_GET['latitude'];
        $longitude = $_GET['longitude'];
        $tanggal = $_GET['tanggal'];
        
        $lokasi = getCityByCoordinates($latitude, $longitude, $pdo);
        if (!$lokasi) {
            echo json_encode(["status" => "error", "message" => "Kota tidak ditemukan untuk koordinat tersebut"]);
            exit;
        }
    } elseif (isset($_GET['lokasi']) && isset($_GET['tanggal'])) {
        $lokasi = $_GET['lokasi'];
        $tanggal = $_GET['tanggal'];
    } else {
        echo json_encode(["status" => "error", "message" => "Parameter lokasi atau koordinat serta tanggal diperlukan"]);
        exit;
    }

    $stmt = $pdo->prepare("SELECT * FROM jadwal_sholat WHERE lokasi = ? AND tanggal = ?");
    $stmt->execute([$lokasi, $tanggal]);
    $result = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($result) {
        echo json_encode(["status" => "success", "data" => $result]);
    } else {
        echo json_encode(["status" => "error", "message" => "Data tidak ditemukan"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Metode request tidak valid"]);
}
