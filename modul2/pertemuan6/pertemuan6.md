# LAPORAN PRAKTIKUM LOGIKA FUZZY

**Ruly Hajar Fauziah**
**240306034**
https://github.com/rulyhajarfauziah

Program Studi Teknologi Informasi
Fakultas Dakwah dan Ilmu Komunikasi
Universitas Islam Negeri Mataram
2026

---

| | |
|---|---|
| **Modul** | Modul 2 |
| **Topik** | Perancangan Aturan Proposisi IF-THEN, Basis Pengetahuan, dan Evaluasi Firing Strength dengan Python |
| **Repository** | https://github.com/rulyhajarfauziah |
| **Tanggal** | 24 Oktober 2026 |

---

## A. Tujuan

Setelah menyelesaikan praktikum ini, mahasiswa diharapkan mampu:

1. Memahami konsep struktur proposisi aturan fuzzy: bagian Antecedent (premis/kondisi) dan Consequent (konklusi/tindakan).
2. Menyusun basis aturan (Rule Base) dan basis pengetahuan (Knowledge Base) berdasarkan logika pakar atau karakteristik domain masalah.
3. Menghitung nilai kekuatan pemicu (Firing Strength / α-predikat) untuk aturan berkondisi majemuk (menggunakan operator AND/OR).
4. Mengimplementasikan struktur data Rule Base dalam bahasa pemrograman Python.
5. Melakukan pengujian evaluasi aturan terhadap berbagai kombinasi input data.
6. Menganalisis kondisi aktivasi aturan (rule firing) serta teknik menangani aturan yang tidak aktif.

## B. Requirement

1. Sistem Operasi yang digunakan: Windows 11 Home Single Language 64-bit (10.0, Build 26100)
2. Browser: Google Chrome Version 130.0.6723.117 (Official Build) (64-bit)
3. Tools yang digunakan: Visual Studio Code

## C. Dasar Teori

### 1. Struktur Aturan Fuzzy IF-THEN

Aturan fuzzy IF-THEN merupakan bentuk penalaran yang digunakan untuk menggambarkan hubungan antara kondisi input dengan hasil keputusan. Pada sistem penentuan harga rumah, terdapat tiga variabel input dan satu variabel output.

| Variabel | Jenis | Himpunan Linguistik |
|---|---|---|
| Lokasi | Input | Sangat Strategis, Strategis, Tidak Strategis |
| Luas Tanah | Input | Kecil, Sedang, Luas |
| Luas Bangunan | Input | Sempit, Sedang, Luas |
| Harga Rumah | Output | Sangat Murah, Murah, Normal, Mahal, Sangat Mahal |

Struktur aturan yang digunakan:

```
IF A AND B AND C THEN D
```

Contoh aturan:

> IF Lokasi is Sangat Strategis AND Luas Tanah is Kecil AND Luas Bangunan is Sempit THEN Harga Rumah is Murah.

Keterangan:

- **Antecedent**: Lokasi Sangat Strategis, Luas Tanah Kecil, dan Luas Bangunan Sempit.
- **Consequent**: Harga Rumah Murah.

### 2. Nilai Kekuatan Pemicu (Firing Strength / α-predikat)

Firing Strength merupakan nilai yang menunjukkan seberapa kuat suatu aturan fuzzy aktif berdasarkan derajat keanggotaan input.

Karena aturan pada sistem penentuan harga rumah menggunakan operator AND, perhitungan dilakukan menggunakan metode MIN.

Rumus:

$$\alpha_i = \min(\mu_A(x), \mu_B(y), \mu_C(z))$$

Keterangan:

- μA(x): Derajat keanggotaan lokasi.
- μB(y): Derajat keanggotaan luas tanah.
- μC(z): Derajat keanggotaan luas bangunan.
- αᵢ: Nilai firing strength.

Jika salah satu derajat keanggotaan bernilai 0, maka aturan tersebut tidak aktif.

### 3. Matriks Basis Aturan (Rule Matrix)

Pada sistem ini terdapat tiga variabel input. Setiap variabel memiliki tiga himpunan linguistik.

Jumlah kombinasi aturan:

$$R = 3 \times 3 \times 3 = 27$$

Berikut matriks basis aturan yang digunakan (baris: Luas Tanah, kolom: Luas Bangunan).

**a. Lokasi Sangat Strategis**

| Luas Tanah | Sempit | Sedang | Luas |
|---|---|---|---|
| Kecil | Murah (R01) | Normal (R02) | Mahal (R03) |
| Sedang | Normal (R04) | Mahal (R05) | Sangat Mahal (R06) |
| Luas | Mahal (R07) | Sangat Mahal (R08) | Sangat Mahal (R09) |

**b. Lokasi Strategis**

| Luas Tanah | Sempit | Sedang | Luas |
|---|---|---|---|
| Kecil | Sangat Murah (R10) | Murah (R11) | Normal (R12) |
| Sedang | Murah (R13) | Normal (R14) | Mahal (R15) |
| Luas | Normal (R16) | Mahal (R17) | Sangat Mahal (R18) |

**c. Lokasi Tidak Strategis**

| Luas Tanah | Sempit | Sedang | Luas |
|---|---|---|---|
| Kecil | Sangat Murah (R19) | Sangat Murah (R20) | Murah (R21) |
| Sedang | Sangat Murah (R22) | Mahal (R23) | Normal (R24) |
| Luas | Murah (R25) | Normal (R26) | Mahal (R27) |

## D. Contoh Perhitungan Manual Firing Strength

Misalkan suatu rumah memiliki hasil fuzzifikasi sebagai berikut. Nilai berikut merupakan data simulasi untuk pengujian.

| Variabel | Himpunan | Derajat Keanggotaan |
|---|---|---|
| Lokasi | Sangat Strategis | 0,2 |
| Lokasi | Strategis | 0,8 |
| Lokasi | Tidak Strategis | 0,0 |
| Luas Tanah | Kecil | 0,0 |
| Luas Tanah | Sedang | 0,6 |
| Luas Tanah | Luas | 0,4 |
| Luas Bangunan | Sempit | 0,2 |
| Luas Bangunan | Sedang | 0,8 |
| Luas Bangunan | Luas | 0,0 |

Perhitungan menggunakan operator MIN.

**1. Aturan R04**

IF Lokasi Sangat Strategis AND Luas Tanah Sedang AND Luas Bangunan Sempit THEN Harga Rumah Normal.

α₄ = min(0,2; 0,6; 0,2) = **0,2**

**2. Aturan R14**

IF Lokasi Strategis AND Luas Tanah Sedang AND Luas Bangunan Sedang THEN Harga Rumah Normal.

α₁₄ = min(0,8; 0,6; 0,8) = **0,6**

**3. Aturan R17**

IF Lokasi Strategis AND Luas Tanah Luas AND Luas Bangunan Sedang THEN Harga Rumah Mahal.

α₁₇ = min(0,8; 0,4; 0,8) = **0,4**

**4. Aturan R27**

IF Lokasi Tidak Strategis AND Luas Tanah Luas AND Luas Bangunan Luas THEN Harga Rumah Mahal.

α₂₇ = min(0,0; 0,4; 0,0) = **0,0**

Aturan R27 tidak aktif karena terdapat derajat keanggotaan bernilai 0 pada kondisi inputnya.

Dari perhitungan tersebut, dapat diketahui bahwa setiap aturan memiliki nilai firing strength yang berbeda sesuai dengan derajat keanggotaan input.

## E. Implementasi

```python
# ==========================================================
# 1. KELAS STRUKTUR ATURAN FUZZY
# ==========================================================
class FuzzyRule:
    def __init__(self, rule_id, antecedent, consequent, operator='AND'):
        """
        antecedent: dict berisi pasangan {'nama_variabel': 'nama_label'}
                    contoh: {'lokasi': 'Strategis', 'tanah': 'Sedang'}
        consequent: dict berisi {'nama_variabel': 'nama_label'}
                    contoh: {'harga': 'Normal'}
        """
        self.rule_id = rule_id
        self.antecedent = antecedent
        self.consequent = consequent
        self.operator = operator.upper()

    def hitung_firing_strength(self, derajat_fuzzifikasi):
        """
        derajat_fuzzifikasi: dict bersarang berisi derajat keanggotaan input,
        contoh: {'lokasi': {'Sangat Strategis': 0.2,
                            'Strategis': 0.8,
                            'Tidak Strategis': 0.0},
                 'tanah': {'Kecil': 0.0,
                           'Sedang': 0.6,
                           'Luas': 0.4},
                 'bangunan': {'Sempit': 0.2,
                              'Sedang': 0.8,
                              'Luas': 0.0}}
        """
        nilai_derajat = []
        for var_nama, label_nama in self.antecedent.items():
            deg = derajat_fuzzifikasi[var_nama].get(label_nama, 0.0)
            nilai_derajat.append(deg)

        if not nilai_derajat:
            return 0.0

        if self.operator == 'AND':
            return min(nilai_derajat)
        elif self.operator == 'OR':
            return max(nilai_derajat)
        else:
            raise ValueError(f"Operator {self.operator} tidak dikenali.")

    def __str__(self):
        syarat = f" {self.operator} ".join([f"{var} is {lbl}" for var, lbl in self.antecedent.items()])
        hasil = ", ".join([f"{var} is {lbl}" for var, lbl in self.consequent.items()])
        return f"[{self.rule_id}] IF {syarat} THEN {hasil}"


# ==========================================================
# 2. INISIALISASI BASIS ATURAN (RULE BASE)
# ==========================================================
rule_base = [
    # LOKASI SANGAT STRATEGIS
    FuzzyRule("R01", {"lokasi": "Sangat Strategis", "tanah": "Kecil", "bangunan": "Sempit"}, {"harga": "Murah"}),
    FuzzyRule("R02", {"lokasi": "Sangat Strategis", "tanah": "Kecil", "bangunan": "Sedang"}, {"harga": "Normal"}),
    FuzzyRule("R03", {"lokasi": "Sangat Strategis", "tanah": "Kecil", "bangunan": "Luas"}, {"harga": "Mahal"}),
    FuzzyRule("R04", {"lokasi": "Sangat Strategis", "tanah": "Sedang", "bangunan": "Sempit"}, {"harga": "Normal"}),
    FuzzyRule("R05", {"lokasi": "Sangat Strategis", "tanah": "Sedang", "bangunan": "Sedang"}, {"harga": "Mahal"}),
    FuzzyRule("R06", {"lokasi": "Sangat Strategis", "tanah": "Sedang", "bangunan": "Luas"}, {"harga": "Sangat Mahal"}),
    FuzzyRule("R07", {"lokasi": "Sangat Strategis", "tanah": "Luas", "bangunan": "Sempit"}, {"harga": "Mahal"}),
    FuzzyRule("R08", {"lokasi": "Sangat Strategis", "tanah": "Luas", "bangunan": "Sedang"}, {"harga": "Sangat Mahal"}),
    FuzzyRule("R09", {"lokasi": "Sangat Strategis", "tanah": "Luas", "bangunan": "Luas"}, {"harga": "Sangat Mahal"}),

    # LOKASI STRATEGIS
    FuzzyRule("R10", {"lokasi": "Strategis", "tanah": "Kecil", "bangunan": "Sempit"}, {"harga": "Sangat Murah"}),
    FuzzyRule("R11", {"lokasi": "Strategis", "tanah": "Kecil", "bangunan": "Sedang"}, {"harga": "Murah"}),
    FuzzyRule("R12", {"lokasi": "Strategis", "tanah": "Kecil", "bangunan": "Luas"}, {"harga": "Normal"}),
    FuzzyRule("R13", {"lokasi": "Strategis", "tanah": "Sedang", "bangunan": "Sempit"}, {"harga": "Murah"}),
    FuzzyRule("R14", {"lokasi": "Strategis", "tanah": "Sedang", "bangunan": "Sedang"}, {"harga": "Normal"}),
    FuzzyRule("R15", {"lokasi": "Strategis", "tanah": "Sedang", "bangunan": "Luas"}, {"harga": "Mahal"}),
    FuzzyRule("R16", {"lokasi": "Strategis", "tanah": "Luas", "bangunan": "Sempit"}, {"harga": "Normal"}),
    FuzzyRule("R17", {"lokasi": "Strategis", "tanah": "Luas", "bangunan": "Sedang"}, {"harga": "Mahal"}),
    FuzzyRule("R18", {"lokasi": "Strategis", "tanah": "Luas", "bangunan": "Luas"}, {"harga": "Sangat Mahal"}),

    # LOKASI TIDAK STRATEGIS
    FuzzyRule("R19", {"lokasi": "Tidak Strategis", "tanah": "Kecil", "bangunan": "Sempit"}, {"harga": "Sangat Murah"}),
    FuzzyRule("R20", {"lokasi": "Tidak Strategis", "tanah": "Kecil", "bangunan": "Sedang"}, {"harga": "Sangat Murah"}),
    FuzzyRule("R21", {"lokasi": "Tidak Strategis", "tanah": "Kecil", "bangunan": "Luas"}, {"harga": "Murah"}),
    FuzzyRule("R22", {"lokasi": "Tidak Strategis", "tanah": "Sedang", "bangunan": "Sempit"}, {"harga": "Sangat Murah"}),
    FuzzyRule("R23", {"lokasi": "Tidak Strategis", "tanah": "Sedang", "bangunan": "Sedang"}, {"harga": "Murah"}),
    FuzzyRule("R24", {"lokasi": "Tidak Strategis", "tanah": "Sedang", "bangunan": "Luas"}, {"harga": "Normal"}),
    FuzzyRule("R25", {"lokasi": "Tidak Strategis", "tanah": "Luas", "bangunan": "Sempit"}, {"harga": "Murah"}),
    FuzzyRule("R26", {"lokasi": "Tidak Strategis", "tanah": "Luas", "bangunan": "Sedang"}, {"harga": "Normal"}),
    FuzzyRule("R27", {"lokasi": "Tidak Strategis", "tanah": "Luas", "bangunan": "Luas"}, {"harga": "Mahal"}),
]


# ==========================================================
# 3. EVALUASI ATURAN TERHADAP DATA INPUT
# ==========================================================
derajat_input_sampel = {
    "lokasi": {
        "Sangat Strategis": 0.2,
        "Strategis": 0.8,
        "Tidak Strategis": 0.0
    },
    "tanah": {
        "Kecil": 0.0,
        "Sedang": 0.6,
        "Luas": 0.4
    },
    "bangunan": {
        "Sempit": 0.2,
        "Sedang": 0.8,
        "Luas": 0.0
    }
}

print("=" * 90)
print("HASIL EVALUASI BASIS ATURAN FUZZY")
print("SISTEM PENENTUAN HARGA RUMAH")
print("=" * 90)

aturan_aktif = []
for rule in rule_base:
    alpha = rule.hitung_firing_strength(derajat_input_sampel)
    output_var = list(rule.consequent.keys())[0]
    output_lbl = rule.consequent[output_var]

    status = f"AKTIF (alpha = {alpha:.2f})" if alpha > 0 else "NONAKTIF"
    print(f"{rule} --> {status}")

    if alpha > 0:
        aturan_aktif.append((rule.rule_id, output_lbl, alpha))

print("\n" + "=" * 90)
print("RINGKASAN ATURAN YANG TERPICU (FIRING RULES):")
print("=" * 90)
for r_id, konklusi, alpha in aturan_aktif:
    print(f" - {r_id:<4} : Harga Rumah = {konklusi:<15} dengan alpha = {alpha:.2f}")
```

**Output:**

```
==========================================================================================
HASIL EVALUASI BASIS ATURAN FUZZY
SISTEM PENENTUAN HARGA RUMAH
==========================================================================================
[R01] IF lokasi is Sangat Strategis AND tanah is Kecil AND bangunan is Sempit THEN harga is Murah --> NONAKTIF
[R02] IF lokasi is Sangat Strategis AND tanah is Kecil AND bangunan is Sedang THEN harga is Normal --> NONAKTIF
[R03] IF lokasi is Sangat Strategis AND tanah is Kecil AND bangunan is Luas THEN harga is Mahal --> NONAKTIF
[R04] IF lokasi is Sangat Strategis AND tanah is Sedang AND bangunan is Sempit THEN harga is Normal --> AKTIF (alpha = 0.20)
[R05] IF lokasi is Sangat Strategis AND tanah is Sedang AND bangunan is Sedang THEN harga is Mahal --> AKTIF (alpha = 0.20)
[R06] IF lokasi is Sangat Strategis AND tanah is Sedang AND bangunan is Luas THEN harga is Sangat Mahal --> NONAKTIF
[R07] IF lokasi is Sangat Strategis AND tanah is Luas AND bangunan is Sempit THEN harga is Mahal --> AKTIF (alpha = 0.20)
[R08] IF lokasi is Sangat Strategis AND tanah is Luas AND bangunan is Sedang THEN harga is Sangat Mahal --> AKTIF (alpha = 0.20)
[R09] IF lokasi is Sangat Strategis AND tanah is Luas AND bangunan is Luas THEN harga is Sangat Mahal --> NONAKTIF
[R10] IF lokasi is Strategis AND tanah is Kecil AND bangunan is Sempit THEN harga is Sangat Murah --> NONAKTIF
[R11] IF lokasi is Strategis AND tanah is Kecil AND bangunan is Sedang THEN harga is Murah --> NONAKTIF
[R12] IF lokasi is Strategis AND tanah is Kecil AND bangunan is Luas THEN harga is Normal --> NONAKTIF
[R13] IF lokasi is Strategis AND tanah is Sedang AND bangunan is Sempit THEN harga is Murah --> AKTIF (alpha = 0.20)
[R14] IF lokasi is Strategis AND tanah is Sedang AND bangunan is Sedang THEN harga is Normal --> AKTIF (alpha = 0.60)
[R15] IF lokasi is Strategis AND tanah is Sedang AND bangunan is Luas THEN harga is Mahal --> NONAKTIF
[R16] IF lokasi is Strategis AND tanah is Luas AND bangunan is Sempit THEN harga is Normal --> AKTIF (alpha = 0.20)
[R17] IF lokasi is Strategis AND tanah is Luas AND bangunan is Sedang THEN harga is Mahal --> AKTIF (alpha = 0.40)
[R18] IF lokasi is Strategis AND tanah is Luas AND bangunan is Luas THEN harga is Sangat Mahal --> NONAKTIF
[R19] IF lokasi is Tidak Strategis AND tanah is Kecil AND bangunan is Sempit THEN harga is Sangat Murah --> NONAKTIF
[R20] IF lokasi is Tidak Strategis AND tanah is Kecil AND bangunan is Sedang THEN harga is Sangat Murah --> NONAKTIF
[R21] IF lokasi is Tidak Strategis AND tanah is Kecil AND bangunan is Luas THEN harga is Murah --> NONAKTIF
[R22] IF lokasi is Tidak Strategis AND tanah is Sedang AND bangunan is Sempit THEN harga is Sangat Murah --> NONAKTIF
[R23] IF lokasi is Tidak Strategis AND tanah is Sedang AND bangunan is Sedang THEN harga is Murah --> NONAKTIF
[R24] IF lokasi is Tidak Strategis AND tanah is Sedang AND bangunan is Luas THEN harga is Normal --> NONAKTIF
[R25] IF lokasi is Tidak Strategis AND tanah is Luas AND bangunan is Sempit THEN harga is Murah --> NONAKTIF
[R26] IF lokasi is Tidak Strategis AND tanah is Luas AND bangunan is Sedang THEN harga is Normal --> NONAKTIF
[R27] IF lokasi is Tidak Strategis AND tanah is Luas AND bangunan is Luas THEN harga is Mahal --> NONAKTIF

==========================================================================================
RINGKASAN ATURAN YANG TERPICU (FIRING RULES):
==========================================================================================
 - R04  : Harga Rumah = Normal          dengan alpha = 0.20
 - R05  : Harga Rumah = Mahal           dengan alpha = 0.20
 - R07  : Harga Rumah = Mahal           dengan alpha = 0.20
 - R08  : Harga Rumah = Sangat Mahal    dengan alpha = 0.20
 - R13  : Harga Rumah = Murah           dengan alpha = 0.20
 - R14  : Harga Rumah = Normal          dengan alpha = 0.60
 - R16  : Harga Rumah = Normal          dengan alpha = 0.20
 - R17  : Harga Rumah = Mahal           dengan alpha = 0.40
```

**Penjelasan implementasi:**

Kode tersebut terdiri dari tiga bagian utama. Bagian pertama membuat kelas `FuzzyRule` untuk menyimpan kondisi dan hasil aturan. Bagian kedua mendefinisikan 27 aturan berdasarkan kombinasi lokasi, luas tanah, dan luas bangunan. Bagian ketiga mengevaluasi setiap aturan menggunakan data hasil fuzzifikasi dan menghitung nilai firing strength dengan operator MIN.

## F. Skenario Pengujian Basis Aturan

Ujilah basis aturan di atas untuk 3 skenario kondisi rumah yang berbeda:

| Skenario | Deskripsi Kasus | Fuzzifikasi Lokasi | Fuzzifikasi Luas Tanah | Fuzzifikasi Luas Bangunan | Daftar Aturan yang Terpacu | Nilai Alpha |
|---|---|---|---|---|---|---|
| A | Rumah berada di lokasi sangat strategis dengan ukuran tanah kecil dan bangunan sempit | Sangat Strategis: 1.0, lainnya: 0.0 | Kecil: 1.0, lainnya: 0.0 | Sempit: 1.0, lainnya: 0.0 | R01 | α₁ = 1.0 |
| B | Rumah berada di lokasi strategis dengan ukuran tanah sedang dan bangunan sedang | Sangat Strategis: 0.3, Strategis: 0.7, Tidak Strategis: 0.0 | Kecil: 0.0, Sedang: 0.6, Luas: 0.4 | Sempit: 0.2, Sedang: 0.8, Luas: 0.0 | R04, R05, R07, R08, R13, R14, R16, R17 | α₄ = 0.2, α₅ = 0.3, α₇ = 0.2, α₈ = 0.3, α₁₃ = 0.2, α₁₄ = 0.6, α₁₆ = 0.2, α₁₇ = 0.4 |
| C | Rumah berada di lokasi tidak strategis dengan ukuran tanah luas dan bangunan luas | Tidak Strategis: 1.0, lainnya: 0.0 | Luas: 1.0, lainnya: 0.0 | Luas: 1.0, lainnya: 0.0 | R27 | α₂₇ = 1.0 |

**Contoh perhitungan nilai Alpha**

- Skenario A – R01: α₁ = min(1,0; 1,0; 1,0) = 1,0
- Skenario B – R14: α₁₄ = min(0,7; 0,6; 0,8) = 0,6
- Skenario B – R17: α₁₇ = min(0,7; 0,4; 0,8) = 0,4
- Skenario C – R27: α₂₇ = min(1,0; 1,0; 1,0) = 1,0

**Analisis hasil pengujian:**

Berdasarkan ketiga skenario tersebut, dapat diketahui bahwa setiap kombinasi nilai derajat keanggotaan menghasilkan aturan fuzzy yang berbeda. Pada skenario A, aturan R01 aktif dengan nilai alpha 1,0 dan menghasilkan kategori harga rumah Murah. Pada skenario B, terdapat delapan aturan yang aktif dengan nilai alpha berbeda-beda karena beberapa variabel memiliki derajat keanggotaan lebih dari satu himpunan. Sementara itu, pada skenario C, aturan R27 aktif dengan nilai alpha 1,0 dan menghasilkan kategori harga rumah Mahal.

Dengan demikian, pengujian menunjukkan bahwa sistem mampu mengaktifkan beberapa aturan secara bersamaan berdasarkan derajat keanggotaan masing-masing variabel input.

## G. Tugas Praktikum 6

**Kasus: Sistem Penentuan Harga Rumah**

Variabel yang digunakan:

1. Lokasi dengan tiga himpunan linguistik: Sangat Strategis, Strategis, dan Tidak Strategis.
2. Luas Tanah dengan tiga himpunan linguistik: Kecil, Sedang, dan Luas.
3. Luas Bangunan dengan tiga himpunan linguistik: Sempit, Sedang, dan Luas.

Variabel output:

- Harga Rumah dengan lima himpunan linguistik: Sangat Murah, Murah, Normal, Mahal, dan Sangat Mahal.

### Instruksi

#### 1. Tabel Matriks Basis Aturan

Jumlah aturan diperoleh dari kombinasi tiga variabel input yang masing-masing memiliki tiga himpunan linguistik.

$$R = 3 \times 3 \times 3 = 27$$

**a. Lokasi Sangat Strategis**

| Luas Tanah | Bangunan Sempit | Bangunan Sedang | Bangunan Luas |
|---|---|---|---|
| Kecil | Murah (R01) | Normal (R02) | Mahal (R03) |
| Sedang | Normal (R04) | Mahal (R05) | Sangat Mahal (R06) |
| Luas | Mahal (R07) | Sangat Mahal (R08) | Sangat Mahal (R09) |

**b. Lokasi Strategis**

| Luas Tanah | Bangunan Sempit | Bangunan Sedang | Bangunan Luas |
|---|---|---|---|
| Kecil | Sangat Murah (R10) | Murah (R11) | Normal (R12) |
| Sedang | Murah (R13) | Normal (R14) | Mahal (R15) |
| Luas | Normal (R16) | Mahal (R17) | Sangat Mahal (R18) |

**c. Lokasi Tidak Strategis**

| Luas Tanah | Bangunan Sempit | Bangunan Sedang | Bangunan Luas |
|---|---|---|---|
| Kecil | Sangat Murah (R19) | Sangat Murah (R20) | Murah (R21) |
| Sedang | Sangat Murah (R22) | Mahal (R23) | Normal (R24) |
| Luas | Murah (R25) | Normal (R26) | Mahal (R27) |

#### 2. Program Python Basis Aturan Fuzzy

Program berikut digunakan untuk mendefinisikan 27 aturan IF-THEN dan menghitung nilai firing strength menggunakan operator MIN untuk kondisi AND.

```python
# ==========================================
# 1. CLASS FUZZY RULE
# ==========================================
class FuzzyRule:
    def __init__(self, id_rule, lokasi, tanah, bangunan, harga):
        self.id_rule = id_rule
        self.lokasi = lokasi
        self.tanah = tanah
        self.bangunan = bangunan
        self.harga = harga

    def hitung_firing_strength(self, derajat_input):
        alpha = min(
            derajat_input["lokasi"].get(self.lokasi, 0),
            derajat_input["tanah"].get(self.tanah, 0),
            derajat_input["bangunan"].get(self.bangunan, 0)
        )
        return alpha

    def __str__(self):
        return (
            f"IF Lokasi {self.lokasi} AND "
            f"Tanah {self.tanah} AND "
            f"Bangunan {self.bangunan} "
            f"THEN Harga {self.harga}"
        )


# ==========================================
# 2. BASIS ATURAN (27 RULES)
# ==========================================
rule_base = [
    # Lokasi Sangat Strategis
    FuzzyRule("R01", "Sangat Strategis", "Kecil", "Sempit", "Murah"),
    FuzzyRule("R02", "Sangat Strategis", "Kecil", "Sedang", "Normal"),
    FuzzyRule("R03", "Sangat Strategis", "Kecil", "Luas", "Mahal"),
    FuzzyRule("R04", "Sangat Strategis", "Sedang", "Sempit", "Normal"),
    FuzzyRule("R05", "Sangat Strategis", "Sedang", "Sedang", "Mahal"),
    FuzzyRule("R06", "Sangat Strategis", "Sedang", "Luas", "Sangat Mahal"),
    FuzzyRule("R07", "Sangat Strategis", "Luas", "Sempit", "Mahal"),
    FuzzyRule("R08", "Sangat Strategis", "Luas", "Sedang", "Sangat Mahal"),
    FuzzyRule("R09", "Sangat Strategis", "Luas", "Luas", "Sangat Mahal"),

    # Lokasi Strategis
    FuzzyRule("R10", "Strategis", "Kecil", "Sempit", "Sangat Murah"),
    FuzzyRule("R11", "Strategis", "Kecil", "Sedang", "Murah"),
    FuzzyRule("R12", "Strategis", "Kecil", "Luas", "Normal"),
    FuzzyRule("R13", "Strategis", "Sedang", "Sempit", "Murah"),
    FuzzyRule("R14", "Strategis", "Sedang", "Sedang", "Normal"),
    FuzzyRule("R15", "Strategis", "Sedang", "Luas", "Mahal"),
    FuzzyRule("R16", "Strategis", "Luas", "Sempit", "Normal"),
    FuzzyRule("R17", "Strategis", "Luas", "Sedang", "Mahal"),
    FuzzyRule("R18", "Strategis", "Luas", "Luas", "Sangat Mahal"),

    # Lokasi Tidak Strategis
    FuzzyRule("R19", "Tidak Strategis", "Kecil", "Sempit", "Sangat Murah"),
    FuzzyRule("R20", "Tidak Strategis", "Kecil", "Sedang", "Sangat Murah"),
    FuzzyRule("R21", "Tidak Strategis", "Kecil", "Luas", "Murah"),
    FuzzyRule("R22", "Tidak Strategis", "Sedang", "Sempit", "Sangat Murah"),
    FuzzyRule("R23", "Tidak Strategis", "Sedang", "Sedang", "Murah"),
    FuzzyRule("R24", "Tidak Strategis", "Sedang", "Luas", "Normal"),
    FuzzyRule("R25", "Tidak Strategis", "Luas", "Sempit", "Murah"),
    FuzzyRule("R26", "Tidak Strategis", "Luas", "Sedang", "Normal"),
    FuzzyRule("R27", "Tidak Strategis", "Luas", "Luas", "Mahal")
]


# ==========================================
# 3. FUNGSI EVALUASI ATURAN
# ==========================================
def evaluasi_aturan(nama_skenario, derajat_input):
    print("\n====================================")
    print("PENGUJIAN", nama_skenario)
    print("====================================")

    aturan_aktif = []

    for rule in rule_base:
        alpha = rule.hitung_firing_strength(derajat_input)
        if alpha > 0:
            aturan_aktif.append((rule, alpha))

    print("Daftar aturan yang aktif:")
    for rule, alpha in aturan_aktif:
        print(f"{rule.id_rule}: {rule} | Alpha = {alpha}")

    if not aturan_aktif:
        print("Tidak ada aturan yang aktif.")

    print("Jumlah aturan aktif:", len(aturan_aktif))


# ==========================================
# 4. DATA INPUT SKENARIO A
# ==========================================
skenario_A = {
    "lokasi": {
        "Sangat Strategis": 1.0,
        "Strategis": 0.0,
        "Tidak Strategis": 0.0
    },
    "tanah": {
        "Kecil": 1.0,
        "Sedang": 0.0,
        "Luas": 0.0
    },
    "bangunan": {
        "Sempit": 1.0,
        "Sedang": 0.0,
        "Luas": 0.0
    }
}

# ==========================================
# 5. DATA INPUT SKENARIO B
# ==========================================
skenario_B = {
    "lokasi": {
        "Sangat Strategis": 0.3,
        "Strategis": 0.7,
        "Tidak Strategis": 0.0
    },
    "tanah": {
        "Kecil": 0.0,
        "Sedang": 0.6,
        "Luas": 0.4
    },
    "bangunan": {
        "Sempit": 0.2,
        "Sedang": 0.8,
        "Luas": 0.0
    }
}

# ==========================================
# 6. DATA INPUT SKENARIO C
# ==========================================
skenario_C = {
    "lokasi": {
        "Sangat Strategis": 0.0,
        "Strategis": 0.0,
        "Tidak Strategis": 1.0
    },
    "tanah": {
        "Kecil": 0.0,
        "Sedang": 0.0,
        "Luas": 1.0
    },
    "bangunan": {
        "Sempit": 0.0,
        "Sedang": 0.0,
        "Luas": 1.0
    }
}

# ==========================================
# 7. MENJALANKAN PENGUJIAN
# ==========================================
evaluasi_aturan("SKENARIO A", skenario_A)
evaluasi_aturan("SKENARIO B", skenario_B)
evaluasi_aturan("SKENARIO C", skenario_C)
```

**Output:**

```
====================================
PENGUJIAN SKENARIO A
====================================
Daftar aturan yang aktif:
R01: IF Lokasi Sangat Strategis AND Tanah Kecil AND Bangunan Sempit THEN Harga Murah | Alpha = 1.0
Jumlah aturan aktif: 1

====================================
PENGUJIAN SKENARIO B
====================================
Daftar aturan yang aktif:
R04: IF Lokasi Sangat Strategis AND Tanah Sedang AND Bangunan Sempit THEN Harga Normal | Alpha = 0.2
R05: IF Lokasi Sangat Strategis AND Tanah Sedang AND Bangunan Sedang THEN Harga Mahal | Alpha = 0.3
R07: IF Lokasi Sangat Strategis AND Tanah Luas AND Bangunan Sempit THEN Harga Mahal | Alpha = 0.2
R08: IF Lokasi Sangat Strategis AND Tanah Luas AND Bangunan Sedang THEN Harga Sangat Mahal | Alpha = 0.3
R13: IF Lokasi Strategis AND Tanah Sedang AND Bangunan Sempit THEN Harga Murah | Alpha = 0.2
R14: IF Lokasi Strategis AND Tanah Sedang AND Bangunan Sedang THEN Harga Normal | Alpha = 0.6
R16: IF Lokasi Strategis AND Tanah Luas AND Bangunan Sempit THEN Harga Normal | Alpha = 0.2
R17: IF Lokasi Strategis AND Tanah Luas AND Bangunan Sedang THEN Harga Mahal | Alpha = 0.4
Jumlah aturan aktif: 8

====================================
PENGUJIAN SKENARIO C
====================================
Daftar aturan yang aktif:
R27: IF Lokasi Tidak Strategis AND Tanah Luas AND Bangunan Luas THEN Harga Mahal | Alpha = 1.0
Jumlah aturan aktif: 1
```

#### 3. Hasil Pengujian Evaluasi Aturan

Pengujian dilakukan menggunakan tiga skenario dengan nilai derajat keanggotaan yang telah ditentukan.

**a. Skenario A**

Kondisi rumah berada di lokasi sangat strategis, memiliki luas tanah kecil, dan luas bangunan sempit.

| Aturan | Perhitungan Alpha | Hasil |
|---|---|---|
| R01 | Min(1.0, 1.0, 1.0) | 1.0 |

Aturan yang aktif adalah R01:
IF Lokasi Sangat Strategis AND Tanah Kecil AND Bangunan Sempit THEN Harga Murah.

**b. Skenario B**

Kondisi rumah berada pada lokasi dengan derajat keanggotaan Sangat Strategis sebesar 0.3 dan Strategis sebesar 0.7. Luas tanah memiliki keanggotaan Sedang sebesar 0.6 dan Luas sebesar 0.4. Luas bangunan memiliki keanggotaan Sempit sebesar 0.2 dan Sedang sebesar 0.8.

| Aturan | Perhitungan Alpha | Hasil |
|---|---|---|
| R04 | min(0.3, 0.6, 0.2) | 0.2 |
| R05 | min(0.3, 0.6, 0.8) | 0.3 |
| R07 | min(0.3, 0.4, 0.2) | 0.2 |
| R08 | min(0.3, 0.4, 0.8) | 0.3 |
| R13 | min(0.7, 0.6, 0.2) | 0.2 |
| R14 | min(0.7, 0.6, 0.8) | 0.6 |
| R16 | min(0.7, 0.4, 0.2) | 0.2 |
| R17 | min(0.7, 0.4, 0.8) | 0.4 |

Terdapat delapan aturan aktif, yaitu R04, R05, R07, R08, R13, R14, R16, dan R17. Nilai alpha terbesar terdapat pada R14 sebesar 0.6.

**c. Skenario C**

Kondisi rumah berada di lokasi tidak strategis, memiliki luas tanah luas, dan luas bangunan luas.

| Aturan | Perhitungan Alpha | Hasil |
|---|---|---|
| R27 | min(1.0, 1.0, 1.0) | 1.0 |

Aturan yang aktif adalah R27:
IF Lokasi Tidak Strategis AND Tanah Luas AND Bangunan Luas THEN Harga Mahal.

#### 4. Daftar Aturan Aktif dan Nilai Firing Strength

Berdasarkan hasil pengujian, diperoleh rangkuman berikut.

| Skenario | Aturan Aktif | Nilai Alpha |
|---|---|---|
| A | R01 | α₁ = 1.0 |
| B | R04, R05, R07, R08, R13, R14, R16, R17 | α₄ = 0.2, α₅ = 0.3, α₇ = 0.2, α₈ = 0.3, α₁₃ = 0.2, α₁₄ = 0.6, α₁₆ = 0.2, α₁₇ = 0.4 |
| C | R27 | α₂₇ = 1.0 |

#### 5. Analisis Hubungan Kondisi Input terhadap Harga Rumah

Berdasarkan basis aturan yang telah dibuat, lokasi menjadi salah satu faktor yang memengaruhi kategori harga rumah. Rumah yang berada di lokasi sangat strategis cenderung memiliki kategori harga lebih tinggi dibandingkan rumah di lokasi tidak strategis apabila luas tanah dan bangunannya memiliki kondisi yang sama.

Selain lokasi, luas tanah juga memengaruhi kategori harga rumah. Semakin luas tanah, kategori harga rumah cenderung meningkat. Hal yang sama berlaku pada luas bangunan. Rumah dengan bangunan yang lebih luas cenderung memiliki kategori harga lebih tinggi dibandingkan rumah dengan bangunan sempit.

Pada skenario A, aturan R01 aktif dengan nilai alpha 1.0 dan menghasilkan kategori harga Murah berdasarkan basis aturan yang digunakan. Pada skenario B, terdapat delapan aturan aktif karena beberapa nilai keanggotaan input memiliki derajat lebih dari nol. Nilai alpha terbesar adalah 0.6 pada aturan R14, yang menghasilkan kategori harga Normal. Sementara itu, pada skenario C, aturan R27 aktif dengan nilai alpha 1.0 dan menghasilkan kategori harga Mahal.

Dari ketiga pengujian tersebut, dapat disimpulkan bahwa kombinasi lokasi, luas tanah, dan luas bangunan memengaruhi kategori harga rumah yang dihasilkan oleh basis aturan fuzzy.

## H. Pertanyaan Analisis

### 1. Apa yang akan terjadi pada sistem inferensi fuzzy jika suatu kombinasi input tidak memicu satu pun aturan (αᵢ = 0 untuk semua i)? Bagaimana cara mencegah kondisi tersebut (completeness of rule base)?

**Jawaban:**

- Jika semua nilai firing strength (αᵢ) bernilai 0, berarti tidak ada aturan yang aktif untuk memproses kombinasi input tersebut. Akibatnya, sistem tidak memiliki hasil inferensi fuzzy yang dapat digunakan untuk menentukan output.
- Kondisi ini dapat dicegah dengan menerapkan *completeness of rule base*, yaitu memastikan seluruh kemungkinan kombinasi input sudah tercakup dalam basis aturan. Selain itu, fungsi keanggotaan perlu dirancang agar seluruh rentang nilai input memiliki derajat keanggotaan pada minimal satu himpunan fuzzy.
- Pada sistem penentuan harga rumah, seluruh kombinasi dari Lokasi, Luas Tanah, dan Luas Bangunan harus memiliki aturan. Karena setiap variabel memiliki tiga himpunan fuzzy, maka diperlukan 27 aturan.

### 2. Jika dua aturan yang aktif menghasilkan konklusi yang sama (misalnya R6 dan R8 sama-sama menghasilkan Prioritas = Tinggi), bagaimanakah kedua nilai α tersebut digabungkan pada tahap agregasi?

**Jawaban:**

- Jika dua atau lebih aturan menghasilkan konklusi yang sama, nilai firing strength dari aturan tersebut digabungkan menggunakan operator MAX pada tahap agregasi.
- Artinya, sistem akan mengambil nilai alpha yang paling besar dari aturan-aturan yang menghasilkan kategori output yang sama.
- Contohnya, jika aturan R04 dan R14 sama-sama menghasilkan kategori harga Normal, dengan nilai:

  α₀₄ = 0.2
  α₁₄ = 0.6

  Maka hasil agregasinya adalah:

  μNormal = max(0.2, 0.6) = 0.6

  Jadi, nilai hasil agregasi untuk kategori harga Normal adalah 0.6.

### 3. Mengapa urutan aturan (rule ordering) pada basis aturan fuzzy tidak memengaruhi hasil akhir sistem? Jelaskan perbedaan karakteristik ini dibandingkan struktur if-elif-else imperatif!

**Jawaban:**

- Urutan aturan pada sistem fuzzy tidak memengaruhi hasil akhir karena setiap aturan dievaluasi secara independen. Artinya, semua aturan diperiksa untuk mengetahui nilai firing strength masing-masing. Jika beberapa aturan memiliki nilai alpha lebih dari 0, aturan-aturan tersebut tetap dapat aktif secara bersamaan.
- Hal ini berbeda dengan struktur if-elif-else pada pemrograman imperatif. Pada struktur tersebut, ketika salah satu kondisi sudah terpenuhi, program akan menjalankan perintah pada kondisi tersebut dan melewati kondisi berikutnya.
- Dengan demikian, sistem fuzzy memungkinkan beberapa aturan aktif secara bersamaan dan hasilnya dapat digabungkan melalui proses agregasi. Sementara itu, struktur if-elif-else hanya menjalankan satu cabang kondisi pertama yang terpenuhi.

## I. Kesimpulan

Kesimpulan yang dapat diperoleh dari praktikum ini adalah:

1. Basis aturan (rule base) digunakan untuk menentukan hubungan antara variabel input, yaitu lokasi, luas tanah, dan luas bangunan terhadap kategori harga rumah.
2. Dari ketiga variabel input tersebut diperoleh 27 aturan IF-THEN yang mencakup seluruh kombinasi himpunan fuzzy. Setiap aturan dievaluasi menggunakan nilai firing strength (α) dengan operator MIN.
3. Hasil pengujian pada tiga skenario menunjukkan bahwa aturan yang aktif berbeda-beda sesuai dengan derajat keanggotaan setiap input. Skenario A mengaktifkan aturan R01 dengan alpha 1.0, skenario B menghasilkan delapan aturan aktif dengan nilai alpha yang berbeda, sedangkan skenario C mengaktifkan aturan R27 dengan alpha 1.0.
4. Praktikum ini juga menunjukkan bahwa beberapa aturan dapat aktif secara bersamaan dan menghasilkan kategori output yang sama. Nilai tersebut kemudian dapat digabungkan menggunakan operator MAX pada tahap agregasi.
5. Dengan demikian, dapat dipahami bahwa penyusunan basis aturan yang lengkap dan evaluasi firing strength merupakan bagian penting dalam sistem inferensi fuzzy. Tahapan ini menjadi dasar untuk melanjutkan proses Mamdani hingga agregasi dan defuzzifikasi agar diperoleh estimasi harga rumah dalam bentuk numerik.

---

*Laporan Praktikum Logika Fuzzy 2026 — Ruly Hajar Fauziah*
