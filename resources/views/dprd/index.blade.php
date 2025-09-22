@extends('layouts.app')

@section('content')
<div class="container">
    @if(session('success'))
    <script>
        toastr.success("{{ session('success') }}");
    </script>
    @endif

    @if(session('error'))
    <script>
        toastr.error("{{ session('error') }}");
    </script>
    @endif

    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="{{ route('dashboard') }}">Dashboard</a></li>
                <li class="breadcrumb-item active" aria-current="page">Daftar Rekomendasi DPRD</li>
            </ol>
        </nav>
    </div>
    <h2 class="mb-4">Daftar Rekomendasi DPRD berdasar tahun sebelumnya</h2>

    <a href="{{ route('export.excel') }}" class="btn btn-primary">Export ke Excel</a>

    <div class="table-responsive">
        <table class="table table-bordered table-striped align-middle text-center">
            <thead class="table-primary">
                <tr>
                    <th style="width: 3%;">No</th>
                    <th style="width: 5%;">Tahun</th>
                    <th style="width: 25%;">Rekomendasi DPRD</th>
                    <th style="width: 20%;">Sub Rekomendasi DPRD</th>
                    <th style="width: 33%;">Tindak Lanjut</th>
                    <th style="width: 7%;">OPD Pengampu</th>
                    <th style="width: 7%;">Aksi</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($data as $item)
                    @php
                        $hasSub = count($item['SubRekomendasiDPRD']) > 0;
                        $rowNumber = 1;
                    @endphp
                    @if ($hasSub)
                        @foreach ($item['SubRekomendasiDPRD'] as $sub)
                            <tr>
                                <td>{{ $item['No'] }} sub {{ $rowNumber++ }}</td>
                                <td>{{ $item['Tahun'] }}</td>
                                <td class="text-start">{{ $item['RekomendasiDPRD'] }}</td>
                                <td class="text-start">{{ $sub['SubRekomendasiDPRD'] }}</td>
                                <td class="text-start">{!! $sub['TindakLanjut'] ?? '-' !!}</td>
                                <td>{{ $sub['OPDPengampu'] }}</td>
                                <td>
                                    <button class="btn btn-sm {{ empty($sub['TindakLanjut']) ? 'btn-danger' : 'btn-success' }}"
                                            data-bs-toggle="modal"
                                            data-bs-target="#modalTindakLanjutSub{{ $sub['KodeSubRekomendasiDPRD'] }}">
                                        {{ empty($sub['TindakLanjut']) ? 'Isi Tindak Lanjut' : 'Ubah Tindak Lanjut' }}
                                    </button>
                                </td>
                            </tr>
                        @endforeach
                    @else
                        @foreach ($item['OPDPengampu'] as $opd)
                            <tr>
                                <td>{{ $item['No'] }}</td>
                                <td>{{ $item['Tahun'] }}</td>
                                <td class="text-start">{{ $item['RekomendasiDPRD'] }}</td>
                                <td>-</td>
                                <td class="text-start">{!! $opd['TindakLanjut'] ?? '-' !!}</td>
                                <td>{{ $opd['NamaOPD'] }}</td>
                                <td>
                                    <button class="btn btn-sm {{ empty($opd['TindakLanjut']) ? 'btn-danger' : 'btn-success' }}"
                                            data-bs-toggle="modal"
                                            data-bs-target="#modalTindakLanjutOPD{{ $item['KodeRekomendasiDPRD'] }}{{ $loop->index }}">
                                        {{ empty($opd['TindakLanjut']) ? 'Isi Tindak Lanjut' : 'Ubah Tindak Lanjut' }}
                                    </button>
                                </td>
                            </tr>
                        @endforeach
                    @endif
                @endforeach
            </tbody>
        </table>
    </div>

    {{-- KUMPULKAN SEMUA MODAL DI LUAR TABLE --}}
    @foreach ($data as $item)
        @if (count($item['SubRekomendasiDPRD']) > 0)
            @foreach ($item['SubRekomendasiDPRD'] as $sub)
                <div class="modal fade" id="modalTindakLanjutSub{{ $sub['KodeSubRekomendasiDPRD'] }}" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-xl">
                        <form method="POST" action="{{ route('dprd.storeTindakLanjut', $item['KodeRekomendasiDPRD']) }}">
                            @csrf
                            <input type="hidden" name="SubRekomendasiDPRD[{{ $sub['KodeSubRekomendasiDPRD'] }}]" value="{{ $sub['SubRekomendasiDPRD'] }}">
                            <div class="modal-content">
                                <div class="modal-header pb-1">
                                    <h5 class="modal-title mb-1">Tindak Lanjut Sub Rekomendasi</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body pt-1 text-start">
                                    <p><strong>Rekomendasi DPRD:</strong> {{ $item['RekomendasiDPRD'] }}</p>
                                    <p><strong>Sub Rekomendasi:</strong> {{ $sub['SubRekomendasiDPRD'] }}</p>
                                    <p><strong>OPD:</strong> {{ $sub['OPDPengampu'] }}</p>
                                    <textarea name="TindakLanjut[{{ $sub['KodeSubRekomendasiDPRD'] }}][{{ $sub['OPDPengampu'] }}]"
                                              class="form-control summernote" rows="8">{{ $sub['TindakLanjut'] ?? '' }}</textarea>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-success">Simpan</button>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            @endforeach
        @else
            @foreach ($item['OPDPengampu'] as $opd)
                <div class="modal fade" id="modalTindakLanjutOPD{{ $item['KodeRekomendasiDPRD'] }}{{ $loop->index }}" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-xl">
                        <form method="POST" action="{{ route('dprd.storeTindakLanjut', $item['KodeRekomendasiDPRD']) }}">
                            @csrf
                            <input type="hidden" name="NamaOPD" value="{{ $opd['NamaOPD'] }}">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Tindak Lanjut Rekomendasi DPRD</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body text-start">
                                    <p><strong>Rekomendasi DPRD:</strong> {{ $item['RekomendasiDPRD'] }}</p>
                                    <p><strong>OPD:</strong> {{ $opd['NamaOPD'] }}</p>
                                    <textarea name="TindakLanjut" class="form-control summernote" rows="5">{{ $opd['TindakLanjut'] ?? '' }}</textarea>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-success">Simpan</button>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            @endforeach
        @endif
    @endforeach

    <script>
        $(document).ready(function() {
            $('.summernote').summernote({
                height: 200,
                tabsize: 2,
                fontNames: ['Arial', 'Times New Roman', 'Courier New', 'Verdana', 'Georgia'],
                fontNamesIgnoreCheck: ['Arial'],
                fontName: 'Arial',
                toolbar: [
                    ['style', ['style']],
                    ['font', ['fontname', 'fontsize', 'bold', 'italic', 'underline', 'clear']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['insert', ['link']],
                    ['view', ['fullscreen', 'codeview', 'help']]
                ],
                callbacks: {
                    onInit: function() {
                        $('.note-editable').css('font-family', 'Arial');
                    },
                    onPaste: function(e) {
                        let clipboardData = (e.originalEvent || e).clipboardData;
                        let bufferText = clipboardData.getData('text/html');
                        if (bufferText) {
                            bufferText = bufferText.replace(/style="[^"]*"/gi, '')
                                                   .replace(/\swidth="[^"]*"/gi, '')
                                                   .replace(/\sheight="[^"]*"/gi, '')
                                                   .replace(/cellpadding="[^"]*"/gi, '')
                                                   .replace(/cellspacing="[^"]*"/gi, '')
                                                   .replace(/border="[^"]*"/gi, '')
                                                   .replace(/<table/gi, '<table class="table table-bordered table-sm"');
                            e.preventDefault();
                            document.execCommand('insertHTML', false, bufferText);
                        }
                    }
                }
            });
        });
    </script>

</div>
@endsection
