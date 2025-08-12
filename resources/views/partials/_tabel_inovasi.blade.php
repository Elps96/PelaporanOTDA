@php
    $kodePertanyaan = $data[0]->KodePertanyaan ?? 'UNKNOWN';
@endphp

<tbody id="tabel-inovasi-body-{{ $kodePertanyaan }}">
    @foreach ($data as $item)
    <tr>
        <td>
            @if ($item->Gambar)
                <img src="{{ asset('storage/' . $item->Gambar) }}" width="80">
            @else
                <span class="text-muted">Tidak ada gambar</span>
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
