<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perbandingan Nama Kota</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: #f4f4f4;
        }
        h2 {
            color: #333;
            border-bottom: 2px solid #666;
            padding-bottom: 5px;
        }
        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .empty {
            color: red;
            font-weight: bold;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <?php
        require_once "../config/database.php";


        $sql_jadwal = "SELECT lokasi FROM jadwal_sholat";
        $sql_kota = "SELECT nama FROM kota";

        $result_jadwal = $conn->query($sql_jadwal);
        $result_kota = $conn->query($sql_kota);

        $jadwal_sholat = [];
        $kota = [];

        while ($row = $result_jadwal->fetch_assoc()) {
            $jadwal_sholat[] = strtolower($row["lokasi"]);
        }

        while ($row = $result_kota->fetch_assoc()) {
            $kota[] = strtolower($row["nama"]);
        }

        $gabungan = array_merge($jadwal_sholat, $kota);
        $jumlah = array_count_values($gabungan);
        ?>
        
        <h2>Hasil Perbandingan Nama Kota</h2>
        <table>
            <tr>
                <th>No</th>
                <th>Nama Kota</th>
                <th>jadwal_sholat (lokasi)</th>
                <th>kota (nama)</th>
            </tr>
            <?php
            $no = 1;
            foreach ($jumlah as $nama => $count) {
                $count_jadwal = in_array($nama, $jadwal_sholat) ? array_count_values($jadwal_sholat)[$nama] : 0;
                $count_kota = in_array($nama, $kota) ? array_count_values($kota)[$nama] : 0;
                echo "<tr><td>$no</td><td>" . ucfirst($nama) . "</td><td>$count_jadwal</td><td>$count_kota</td></tr>";
                $no++;
            }
            ?>
        </table>
        
        <h2>Nama Kota yang Tidak Memiliki Pasangan</h2>
        <table>
            <tr>
                <th>No</th>
                <th>Kategori</th>
                <th>Nama Kota</th>
            </tr>
            <?php
            $beda_jadwal = array_diff($jadwal_sholat, $kota);
            $beda_kota = array_diff($kota, $jadwal_sholat);
            $total_jadwal = count($beda_jadwal);
            $total_kota = count($beda_kota);
            $no = 1;

            if (empty($beda_jadwal) && empty($beda_kota)) {
                echo "<tr><td colspan='3' class='empty'>Tidak ada data</td></tr>";
            } else {
                if (!empty($beda_jadwal)) {
                    foreach ($beda_jadwal as $nama) {
                        echo "<tr><td>$no</td><td>jadwal_sholat (lokasi)</td><td>" . ucfirst($nama) . "</td></tr>";
                        $no++;
                    }
                }
                if (!empty($beda_kota)) {
                    foreach ($beda_kota as $nama) {
                        echo "<tr><td>$no</td><td>kota (nama)</td><td>" . ucfirst($nama) . "</td></tr>";
                        $no++;
                    }
                }
            }
            ?>
        </table>
        <h2>Ringkasan</h2>
        <p>Total kota tanpa pasangan di jadwal_sholat (lokasi): <strong><?php echo $total_jadwal; ?></strong></p>
        <p>Total kota tanpa pasangan di kota (nama): <strong><?php echo $total_kota; ?></strong></p>
        <p>Nama kota di jadwal_sholat (lokasi) yang tidak memiliki pasangan: <strong><?php echo implode(", ", array_map('ucfirst', $beda_jadwal)); ?></strong></p>
        <p>Nama kota di kota (nama) yang tidak memiliki pasangan: <strong><?php echo implode(", ", array_map('ucfirst', $beda_kota)); ?></strong></p>

        
        <?php $conn->close(); ?>
    </div>
</body>
</html>
