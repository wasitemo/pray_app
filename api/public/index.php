<?php
header("Content-Type: application/json");
require_once "../config/database.php";

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    if (isset($_GET['lokasi']) && isset($_GET['tanggal'])) {
        $lokasi = $_GET['lokasi'];
        $tanggal = $_GET['tanggal'];

        $stmt = $pdo->prepare("SELECT subuh, dzuhur, ashar, maghrib, isya FROM jadwal_sholat WHERE lokasi = ? AND tanggal = ?");
        $stmt->execute([$lokasi, $tanggal]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($result) {
            echo json_encode(["status" => "success", "data" => $result]);
        } else {
            echo json_encode(["status" => "error", "message" => "Data tidak ditemukan"]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "Parameter lokasi dan tanggal diperlukan"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Metode request tidak valid"]);
}
?>
