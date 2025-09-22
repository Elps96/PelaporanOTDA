@php
    $kodePertanyaan = $data[0]->KodePertanyaan ?? 'UNKNOWN';
@endphp

<tbody id="tabel-inovasi-body-{{ $kodePertanyaan }}">
    @foreach ($data as $item)
    <tr>
        <td>
            @if ($item->Gambar)
                @php
                    $ext = strtolower(pathinfo($item->Gambar, PATHINFO_EXTENSION));
                @endphp

                @if (in_array($ext, ['jpg', 'jpeg', 'png', 'gif', 'webp']))
                    <img src="{{ asset('storage/' . $item->Gambar) }}" width="80">
                @elseif ($ext === 'pdf')
                    <a href="{{ asset('storage/' . $item->Gambar) }}" target="_blank">📄 Lihat PDF</a>
                @elseif (in_array($ext, ['doc','docx']))
                    <a href="{{ asset('storage/' . $item->Gambar) }}" target="_blank">📝 Lihat Word</a>
                @elseif (in_array($ext, ['xls','xlsx']))
                    <a href="{{ asset('storage/' . $item->Gambar) }}" target="_blank">📊 Lihat Excel</a>
                @elseif (in_array($ext, ['ppt','pptx']))
                    <a href="{{ asset('storage/' . $item->Gambar) }}" target="_blank">📑 Lihat PowerPoint</a>
                @else
                    <a href="{{ asset('storage/' . $item->Gambar) }}" target="_blank">📎 Lihat File</a>
                @endif
            @else
                <span class="text-muted">Tidak ada file/gambar</span>
            @endif
        </td>
        <td>{{ $item->Nama }}</td>
        <td>{{ $item->Deskripsi }}</td>
        <td>{{ $item->SKPD }}</td>
        <td>
            <button type="button" class="btn btn-sm btn-danger"
                    onclick="hapusInovasi({{ $item->No }}, '{{ $item->KodePertanyaan }}')">
                Hapus
            </button>
        </td>
    </tr>
    @endforeach
</tbody>
