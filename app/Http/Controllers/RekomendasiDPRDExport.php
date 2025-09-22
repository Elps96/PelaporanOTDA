<?php

namespace App\Http\Controllers;

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use PhpOffice\PhpSpreadsheet\Style\Border;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use App\Models\RekomendasiDPRD;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class RekomendasiDPRDExport extends Controller
{
    public function export()
{
    $spreadsheet = new Spreadsheet();
    $sheet = $spreadsheet->getActiveSheet();

    // Judul
    $sheet->mergeCells('A1:G1');
    $sheet->setCellValue('A1', 'Daftar Rekomendasi DPRD');
    $sheet->getStyle('A1')->getFont()->setBold(true)->setSize(16);
    $sheet->getStyle('A1')->getAlignment()->setHorizontal(Alignment::HORIZONTAL_CENTER);

    // Header
    $headers = ['No', 'Tahun', 'Rekomendasi DPRD', 'Sub Rekomendasi DPRD', 'Tindak Lanjut', 'OPD Pengampu', 'Aksi'];
    $col = 'A';
    foreach ($headers as $header) {
        $sheet->setCellValue($col.'3', $header);
        $col++;
    }

    // Style Header
    $sheet->getStyle('A3:G3')->getFont()->setBold(true);
    $sheet->getStyle('A3:G3')->getFill()->setFillType(Fill::FILL_SOLID)
          ->getStartColor()->setARGB('FFD9E1F2');
    $sheet->getStyle('A3:G3')->getAlignment()->setHorizontal(Alignment::HORIZONTAL_CENTER);

    $OPDPengampu = Auth::user()->name;
    if (strtoupper($OPDPengampu) === 'PEMERINTAHAN') {
        $data = DB::select("
            SELECT
                A.No,
                A.Tahun,
                A.KodeRekomendasiDPRD,
                A.RekomendasiDPRD,
                C.KodeSubRekomendasiDPRD,
                C.SubRekomendasiDPRD,
                COALESCE(B.TindakLanjut, C.TindakLanjut) AS TindakLanjut,
                COALESCE(B.OPDPengampu, C.OPDPengampu) AS OPDPengampu
            FROM tb_rekomendasi_dprd A
            LEFT JOIN tb_rekomendasi_dprd_opd B 
                ON A.KodeRekomendasiDPRD = B.KodeRekomendasiDPRD
            LEFT JOIN tb_rekomendasi_dprd_sub C 
                ON A.KodeRekomendasiDPRD = C.KodeRekomendasiDPRD"
                );
    } else {
                    $data = DB::select("
            SELECT
                A.No,
                A.Tahun,
                A.KodeRekomendasiDPRD,
                A.RekomendasiDPRD,
                C.KodeSubRekomendasiDPRD,
                C.SubRekomendasiDPRD,
                COALESCE(B.TindakLanjut, C.TindakLanjut) AS TindakLanjut,
                COALESCE(B.OPDPengampu, C.OPDPengampu) AS OPDPengampu
            FROM tb_rekomendasi_dprd A
            LEFT JOIN tb_rekomendasi_dprd_opd B 
                ON A.KodeRekomendasiDPRD = B.KodeRekomendasiDPRD
            LEFT JOIN tb_rekomendasi_dprd_sub C 
                ON A.KodeRekomendasiDPRD = C.KodeRekomendasiDPRD
            WHERE COALESCE(B.OPDPengampu, C.OPDPengampu) = ?", [$OPDPengampu]
                );
    }
    $row = 4;
    $no = 1;

    function htmlToExcelText($html) {
    $text = html_entity_decode($html);
    $text = str_replace('&nbsp;', ' ', $html); // hilangkan nbsp
    // Ganti <br> dan <p> dengan newline
    $text = preg_replace('/<br\s*\/?>/i', "\n", $text);
    $text = preg_replace('/<\/p>/i', "\n", $text);
    // Hilangkan <p> pembuka
    $text = preg_replace('/<p[^>]*>/i', '', $text);
    // Ganti <li> dengan nomor atau bullet
    $text = preg_replace('/<li[^>]*>/i', '• ', $text);
    $text = str_replace('</li>', "\n", $text);
    // Hilangkan semua tag HTML lain
    $text = strip_tags($text);
    return $text;
}
    foreach ($data as $item) {
       
        $sheet->setCellValue('A'.$row, $no++);
        $sheet->setCellValue('B'.$row, $item->Tahun);
        $sheet->setCellValue('C'.$row, strip_tags($item->RekomendasiDPRD));
        $sheet->setCellValue('D'.$row, strip_tags($item->SubRekomendasiDPRD));
        $sheet->setCellValue('E'.$row, htmlToExcelText($item->TindakLanjut));
        $sheet->setCellValue('F'.$row, $item->OPDPengampu);
        // $sheet->setCellValue('G'.$row, ''); // kolom aksi biasanya kosong di export
        // Wrap text untuk kolom C, D, E (Rekomendasi, Sub Rekomendasi, Tindak Lanjut)
        $sheet->getStyle('C4:C'.($row-1))->getAlignment()->setWrapText(true);
        $sheet->getStyle('D4:D'.($row-1))->getAlignment()->setWrapText(true);
        $sheet->getStyle('E4:E'.($row-1))->getAlignment()->setWrapText(true);

        $row++;
    }

    // Border
    $sheet->getColumnDimension('C')->setWidth(60); // atur lebar kolom C, misal 60 karakter
    $sheet->getColumnDimension('D')->setWidth(60);
    $sheet->getColumnDimension('E')->setWidth(60);
    $styleArray = [
        'borders' => [
            'allBorders' => [
                'borderStyle' => Border::BORDER_THIN,
                'color' => ['argb' => 'FF000000'],
            ],
        ],
    ];
    $sheet->getStyle('A3:G'.($row-1))->applyFromArray($styleArray);
    $sheet->getStyle('C4:C'.($row-1))->getAlignment()->setWrapText(true);

    // Auto width
    foreach (range('A', 'G') as $col) {
        if (!in_array($col, ['C', 'D', 'E'])) {
            $sheet->getColumnDimension($col)->setAutoSize(true);
        }
    }
    // Download file
    $writer = new Xlsx($spreadsheet);
    $fileName = 'Rekomendasi_DPRD.xlsx';
    $temp_file = tempnam(sys_get_temp_dir(), $fileName);
    $writer->save($temp_file);

    return response()->download($temp_file, $fileName)->deleteFileAfterSend(true);
}
}
