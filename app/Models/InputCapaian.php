<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InputCapaian extends Model
{
    protected $table = 'tb_input_capaian';

    protected $fillable = [
        'KodePertanyaan',
        'Capaian',
        'FileBukti',
        'Keterangan',
    ];
}
