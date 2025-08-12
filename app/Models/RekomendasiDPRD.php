<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class RekomendasiDPRD extends Model
{
    use HasFactory;

    protected $table = 'tb_rekomendasi_dprd';

    protected $fillable = [
        'No',
        'RekomendasiDPRD',
        'SubRekomendasiDPRD',
        'Tahun',
        'TindakLanjut',
        'OPDPengampu',
    ];    
}
