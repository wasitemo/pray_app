<?php
header("Content-Type: application/json");
require_once "../config/database.php";

function getCityByCoordinates($latitude, $longitude) {
    $cities = [
        'Banjarmasin' => ['lat_min' => -3.5, 'lat_max' => -3.0, 'lon_min' => 114.5, 'lon_max' => 115.0],
        'Jakarta' => ['lat_min' => -6.3, 'lat_max' => -6.1, 'lon_min' => 106.7, 'lon_max' => 107.0],
        'Surabaya' => ['lat_min' => -7.3, 'lat_max' => -7.2, 'lon_min' => 112.6, 'lon_max' => 112.8],
        'Bandung' => ['lat_min' => -6.95, 'lat_max' => -6.90, 'lon_min' => 107.5, 'lon_max' => 107.7],
        'Medan' => ['lat_min' => 3.5, 'lat_max' => 3.6, 'lon_min' => 98.6, 'lon_max' => 98.7],
        'Semarang' => ['lat_min' => -7.0, 'lat_max' => -6.9, 'lon_min' => 110.3, 'lon_max' => 110.5],
        'Palembang' => ['lat_min' => -3.0, 'lat_max' => -2.9, 'lon_min' => 104.7, 'lon_max' => 104.8],
        'Makassar' => ['lat_min' => -5.2, 'lat_max' => -5.1, 'lon_min' => 119.4, 'lon_max' => 119.5],
        'Denpasar' => ['lat_min' => -8.7, 'lat_max' => -8.6, 'lon_min' => 115.2, 'lon_max' => 115.3],
        'Yogyakarta' => ['lat_min' => -7.8, 'lat_max' => -7.7, 'lon_min' => 110.3, 'lon_max' => 110.4]
    ];

    foreach ($cities as $city => $coords) {
        if ($latitude >= $coords['lat_min'] && $latitude <= $coords['lat_max'] &&
            $longitude >= $coords['lon_min'] && $longitude <= $coords['lon_max']) {
            return $city;
        }
    }
    return null;
}

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    if (isset($_GET['latitude']) && isset($_GET['longitude']) && isset($_GET['tanggal'])) {
        $latitude = $_GET['latitude'];
        $longitude = $_GET['longitude'];
        $tanggal = $_GET['tanggal'];
        
        $lokasi = getCityByCoordinates($latitude, $longitude);
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
?>
