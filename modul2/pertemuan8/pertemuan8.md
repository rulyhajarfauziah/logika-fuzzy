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
| **Topik** | Alur Kerja Komprehensif Sistem Inferensi Fuzzy: Fuzzifikasi, Evaluasi Aturan, Agregasi, dan Defuzzifikasi |
| **Repository** | https://github.com/rulyhajarfauziah |
| **Tanggal** | 24 Oktober 2026 |

---

## A. Tujuan

Setelah menyelesaikan praktikum ini, mahasiswa diharapkan mampu:

1. Memahami arsitektur lengkap dan empat pilar utama Fuzzy Inference System (FIS).
2. Menjelaskan aliran transformasi data: dari nilai konkret (crisp input) → derajat keanggotaan → evaluasi aturan → agregasi konsekuen → keputusan konkret (crisp output).
3. Mengimplementasikan pipeline pemrosesan FIS secara modular menggunakan Python.
4. Memvisualisasikan setiap tahap komputasi inferensi fuzzy dalam bentuk grafik proses.
5. Menganalisis pengaruh agregasi konklusi terhadap bentuk daerah solusi fuzzy sebelum proses defuzzifikasi.

## B. Requirement

1. Sistem Operasi yang digunakan: Windows 11 Home Single Language 64-bit (10.0, Build 26100)
2. Browser: Google Chrome Version 130.0.6723.117 (Official Build) (64-bit)
3. Tools yang digunakan: Visual Studio Code

## C. Dasar Teori

### 1. Arsitektur Empat Pilar Fuzzy Inference System

Fuzzy Inference System (FIS) adalah kerangka kerja komputasi cerdas yang memetakan ruang input ke ruang output menggunakan penalaran berbasis aturan fuzzy. FIS terdiri dari empat komponen utama:

```
┌──────────────────── FUZZY INFERENCE SYSTEM (FIS) ────────────────────┐
│                                                                      │
│  INPUT CRISP                                          OUTPUT CRISP   │
│      │                                                     ▲         │
│      ▼                                                     │         │
│  ┌──────────┐      ┌─────────────────────┐          ┌───────────┐    │
│  │  FUZZI-  │ ───► │  INFERENCE ENGINE   │ ───────► │  DEFUZZI- │    │
│  │  FIKASI  │      │ (Penalaran Aturan   │          │  FIKASI   │    │
│  └──────────┘      │  dan Agregasi)      │          └───────────┘    │
│                    └─────────────────────┘                           │
│                              ▲                                       │
│                    ┌─────────────────────┐                           │
│                    │   KNOWLEDGE BASE    │                           │
│                    │  (Rule Base &       │                           │
│                    │   Database MF)      │                           │
│                    └─────────────────────┘                           │
└──────────────────────────────────────────────────────────────────────┘
```

a. **Basis Pengetahuan (*Knowledge Base*)**: Berisi definisi fungsi keanggotaan seluruh variabel (*Database*) dan kumpulan aturan IF-THEN (*Rule Base*).

b. **Unit Fuzzifikasi (*Fuzzification Interface*)**: Mengubah nilai input crisp menjadi derajat keanggotaan linguistik μ ∈ [0, 1].

c. **Mesin Inferensi (*Inference Engine*)**: Menerapkan operator logika fuzzy pada premis aturan, menerapkan metode implikasi (misal: pemotongan kurva/Mamdani Min), dan menggabungkan hasil seluruh aturan aktif ke dalam satu fungsi keanggotaan gabungan (*Aggregation*).

d. **Unit Defuzzifikasi (*Defuzzification Interface*)**: Mengubah daerah himpunan fuzzy hasil agregasi kembali menjadi satu nilai tegas (*crisp output*), misalnya melalui metode titik berat (*Centroid*).

### 2. Variabel dan Himpunan Fuzzy

Sistem penentuan harga rumah memiliki tiga variabel input dan satu variabel output.

| Variabel | Jenis | Himpunan Fuzzy |
|---|---|---|
| Lokasi | Input | Sangat Strategis, Strategis, Tidak Strategis |
| Luas Tanah | Input | Kecil, Sedang, Luas |
| Luas Bangunan | Input | Sempit, Sedang, Luas |
| Harga Rumah | Output | Sangat Murah, Murah, Normal, Mahal, Sangat Mahal |

### 3. Parameter Fungsi Keanggotaan

Fungsi keanggotaan digunakan untuk menentukan derajat keanggotaan suatu nilai terhadap himpunan fuzzy. Pada sistem ini digunakan dua bentuk fungsi keanggotaan, yaitu segitiga (Triangle) dan trapesium (Trapezoid).

**a. Variabel Lokasi**

| Himpunan | Bentuk | Parameter |
|---|---|---|
| Sangat Strategis | Trapesium | [0, 0, 10, 20] |
| Strategis | Segitiga | [10, 25, 40] |
| Tidak Strategis | Trapesium | [30, 40, 50, 50] |

**b. Variabel Luas Tanah**

| Himpunan | Bentuk | Parameter |
|---|---|---|
| Kecil | Trapesium | [36, 36, 60, 100] |
| Sedang | Segitiga | [72, 120, 168] |
| Luas | Trapesium | [140, 170, 200, 200] |

**c. Variabel Luas Bangunan**

| Himpunan | Bentuk | Parameter |
|---|---|---|
| Sempit | Trapesium | [21, 21, 36, 60] |
| Sedang | Segitiga | [45, 80, 115] |
| Luas | Trapesium | [90, 115, 150, 150] |

**d. Variabel Harga Rumah**

| Himpunan | Bentuk | Parameter |
|---|---|---|
| Sangat Murah | Trapesium | [1, 1, 3, 7] |
| Murah | Segitiga | [3, 7, 11] |
| Normal | Segitiga | [7, 11, 15] |
| Mahal | Segitiga | [11, 15, 19] |
| Sangat Mahal | Trapesium | [15, 19, 23, 23] |

## D. Alur Komputasi Step-by-Step

Pada praktikum ini, digunakan sistem penentuan harga rumah dengan tiga variabel input:

- **Input 1**: Lokasi rumah (Sangat strategis, strategis, tidak strategis).
- **Input 2**: Luas tanah (Kecil, sedang, luas).
- **Input 3**: Luas bangunan (Sempit, sedang, luas).
- **Output**: Harga rumah dalam kategori Sangat Murah, Murah, Normal, Mahal, dan Sangat Mahal.

### Tahap 1: Fuzzifikasi

Pada Skenario B Praktikum 6, diperoleh nilai keanggotaan sebagai berikut:

- x₁ (Lokasi) → μ_SangatStrategis = 0,2; μ_Strategis = 0,8; μ_TidakStrategis = 0,0.
- x₂ (Luas Tanah) → μ_Kecil = 0,0; μ_Sedang = 0,6; μ_Luas = 0,4.
- x₃ (Luas Bangunan) → μ_Sempit = 0,2; μ_Sedang = 0,8; μ_Luas = 0,0.

### Tahap 2: Evaluasi Aturan dan Implikasi

Berdasarkan Skenario B Praktikum 6, terdapat 8 aturan yang aktif.

**1. Rule 4:** IF Lokasi is Sangat Strategis AND Luas Tanah is Sedang AND Luas Bangunan is Sempit THEN Harga Rumah is Normal.

α₄ = min(0,2; 0,6; 0,2) = 0,2

Implikasi: Kurva output Harga Rumah Normal dipotong setinggi 0,2.

**2. Rule 5:** IF Lokasi is Sangat Strategis AND Luas Tanah is Sedang AND Luas Bangunan is Sedang THEN Harga Rumah is Mahal.

α₅ = min(0,2; 0,6; 0,8) = 0,2

Implikasi: Kurva output Harga Rumah Mahal dipotong setinggi 0,2.

**3. Rule 7:** IF Lokasi is Sangat Strategis AND Luas Tanah is Luas AND Luas Bangunan is Sempit THEN Harga Rumah is Mahal.

α₇ = min(0,2; 0,4; 0,2) = 0,2

Implikasi: Kurva output Harga Rumah Mahal dipotong setinggi 0,2.

**4. Rule 8:** IF Lokasi is Sangat Strategis AND Luas Tanah is Luas AND Luas Bangunan is Sedang THEN Harga Rumah is Sangat Mahal.

α₈ = min(0,2; 0,4; 0,8) = 0,2

Implikasi: Kurva output Harga Rumah Sangat Mahal dipotong setinggi 0,2.

**5. Rule 13:** IF Lokasi is Strategis AND Luas Tanah is Sedang AND Luas Bangunan is Sempit THEN Harga Rumah is Murah.

α₁₃ = min(0,8; 0,6; 0,2) = 0,2

Implikasi: Kurva output Harga Rumah Murah dipotong setinggi 0,2.

**6. Rule 14:** IF Lokasi is Strategis AND Luas Tanah is Sedang AND Luas Bangunan is Sedang THEN Harga Rumah is Normal.

α₁₄ = min(0,8; 0,6; 0,8) = 0,6

Implikasi: Kurva output Harga Rumah Normal dipotong setinggi 0,6.

**7. Rule 16:** IF Lokasi is Strategis AND Luas Tanah is Luas AND Luas Bangunan is Sempit THEN Harga Rumah is Normal.

α₁₆ = min(0,8; 0,4; 0,2) = 0,2

Implikasi: Kurva output Harga Rumah Normal dipotong setinggi 0,2.

**8. Rule 17:** IF Lokasi is Strategis AND Luas Tanah is Luas AND Luas Bangunan is Sedang THEN Harga Rumah is Mahal.

α₁₇ = min(0,8; 0,4; 0,8) = 0,4

Implikasi: Kurva output Harga Rumah Mahal dipotong setinggi 0,4.

### Tahap 3: Agregasi (MAX Operator)

Agregasi merupakan proses menggabungkan seluruh hasil implikasi dari aturan yang aktif menggunakan operator maksimum.

Perhitungan berdasarkan kategori output:

- Sangat Murah = 0,0 karena tidak ada aturan aktif.
- Murah = 0,2 dari Rule 13.
- Normal = max(0,2; 0,6; 0,2) = 0,6.
- Mahal = max(0,2; 0,2; 0,4) = 0,4.
- Sangat Mahal = 0,2 dari Rule 8.

Rumus agregasi:

$$\mu_{Agg}(z) = \max(\mu_{R1}(z), \mu_{R2}(z), \dots, \mu_{R8}(z))$$

### Tahap 4: Defuzzifikasi (Centroid)

Defuzzifikasi merupakan proses mengubah hasil fuzzy menjadi nilai tegas (crisp output). Metode yang digunakan adalah Centroid atau Center of Gravity, yaitu menghitung titik pusat dari daerah hasil agregasi.

Rumus Centroid:

$$z^* = \frac{\int z \cdot \mu_{Agg}(z)\, dz}{\int \mu_{Agg}(z)\, dz}$$

Untuk perhitungan menggunakan domain diskrit, rumusnya menjadi:

$$z^* = \frac{\sum z_i \cdot \mu_{Agg}(z_i)}{\sum \mu_{Agg}(z_i)}$$

Nilai hasil defuzzifikasi kemudian dikalikan dengan Rp100.000.000 karena setiap satu satuan pada skala harga mewakili Rp100 juta.

## E. Implementasi Program Python

```python
import numpy as np
import matplotlib.pyplot as plt

# ==========================================================
# 1. DEFINISI FUNGSI KEANGGOTAAN SEGI TIGA & TRAPESIUM
# ==========================================================
def trimf(x, params):
    """Fungsi keanggotaan segitiga [a, b, c]"""
    a, b, c = params
    y = np.zeros_like(x)

    idx1 = (x > a) & (x <= b)
    if np.any(idx1) and b != a:
        y[idx1] = (x[idx1] - a) / (b - a)

    idx2 = (x > b) & (x < c)
    if np.any(idx2) and c != b:
        y[idx2] = (c - x[idx2]) / (c - b)

    return np.clip(y, 0.0, 1.0)


def trapmf(x, params):
    """Fungsi keanggotaan trapesium [a, b, c, d]"""
    a, b, c, d = params
    y = np.zeros_like(x)

    if a == b:
        y[x <= b] = 1.0
    else:
        idx1 = (x > a) & (x < b)
        y[idx1] = (x[idx1] - a) / (b - a)

    y[(x >= b) & (x <= c)] = 1.0

    if c == d:
        y[x >= c] = 1.0
    else:
        idx2 = (x > c) & (x < d)
        y[idx2] = (d - x[idx2]) / (d - c)

    return np.clip(y, 0.0, 1.0)


# ==========================================================
# 2. DEFINISI DOMAIN DAN SEMESTA
# ==========================================================
# Domain Output: Harga Rumah [1 - 23]
z = np.linspace(1, 23, 300)

mf_sangat_murah = trapmf(z, [1, 1, 3, 7])
mf_murah = trimf(z, [3, 7, 11])
mf_normal = trimf(z, [7, 11, 15])
mf_mahal = trimf(z, [11, 15, 19])
mf_sangat_mahal = trapmf(z, [15, 19, 23, 23])


# ==========================================================
# 3. SIMULASI NILAI FIRING STRENGTH DARI ATURAN
# ==========================================================
# Skenario B Praktikum 6
# Berdasarkan 8 aturan yang aktif
alpha_sangat_murah = 0.00
alpha_murah = 0.20
alpha_normal = 0.60
alpha_mahal = 0.40
alpha_sangat_mahal = 0.20

# Implikasi (Mamdani Min)
imp_sangat_murah = np.minimum(
    alpha_sangat_murah, mf_sangat_murah
)
imp_murah = np.minimum(
    alpha_murah, mf_murah
)
imp_normal = np.minimum(
    alpha_normal, mf_normal
)
imp_mahal = np.minimum(
    alpha_mahal, mf_mahal
)
imp_sangat_mahal = np.minimum(
    alpha_sangat_mahal, mf_sangat_mahal
)

# Agregasi (Max)
agregasi = np.maximum.reduce([
    imp_sangat_murah,
    imp_murah,
    imp_normal,
    imp_mahal,
    imp_sangat_mahal
])


# ==========================================================
# 4. DEFUZZIFIKASI CENTROID (DISKRIT)
# ==========================================================
def defuzzifikasi_centroid(x_vals, mu_vals):
    total_mu = np.sum(mu_vals)
    if total_mu == 0:
        return 0.0
    return np.sum(x_vals * mu_vals) / total_mu


z_crisp = defuzzifikasi_centroid(z, agregasi)

# Konversi skala harga ke Rupiah
harga_rumah = z_crisp * 100_000_000


# ==========================================================
# 5. VISUALISASI PIPELINE FIS
# ==========================================================
plt.figure(figsize=(12, 6))

plt.plot(
    z, mf_sangat_murah, 'g--',
    label='MF Sangat Murah', alpha=0.5
)
plt.plot(
    z, mf_murah, 'b--',
    label='MF Murah', alpha=0.5
)
plt.plot(
    z, mf_normal, 'c--',
    label='MF Normal', alpha=0.5
)
plt.plot(
    z, mf_mahal, 'r--',
    label='MF Mahal', alpha=0.5
)
plt.plot(
    z, mf_sangat_mahal, 'm--',
    label='MF Sangat Mahal', alpha=0.5
)

# Gambar kurva terpotong & area agregasi
plt.fill_between(
    z, 0, agregasi,
    color='purple',
    alpha=0.35,
    label='Daerah Agregasi Fuzzy'
)

plt.plot(
    z, agregasi,
    color='purple',
    linewidth=2.5
)

# Garis titik berat hasil defuzzifikasi
plt.axvline(
    x=z_crisp,
    color='black',
    linewidth=2.5,
    linestyle='-',
    label=f'Crisp Output (Centroid = {z_crisp:.2f})'
)

plt.scatter(
    [z_crisp], [0],
    color='black',
    s=80,
    zorder=6
)

plt.title(
    'Arsitektur FIS: Hasil Implikasi, Agregasi, dan Defuzzifikasi Centroid',
    fontsize=13,
    fontweight='bold'
)
plt.xlabel('Skala Harga Rumah', fontsize=11)
plt.ylabel('Derajat Keanggotaan μ(z)', fontsize=11)
plt.ylim(-0.05, 1.05)
plt.grid(True, linestyle=':', alpha=0.6)
plt.legend(loc='upper left', fontsize=10)
plt.tight_layout()

plt.savefig(
    'pipeline_fis_harga_rumah.png',
    dpi=300
)

plt.show()

# ==========================================================
# 6. MENAMPILKAN HASIL KEPUTUSAN
# ==========================================================
print("Keputusan Akhir Sistem FIS:")
print(f" - Nilai Centroid: {z_crisp:.4f}")
print(f" - Estimasi Harga Rumah: Rp{harga_rumah:,.0f}")
```

**Output:**

```
Keputusan Akhir Sistem FIS:
 - Nilai Centroid: 12.8874
 - Estimasi Harga Rumah: Rp1,288,743,136
```

Grafik hasil implikasi, agregasi, dan defuzzifikasi Centroid (daerah agregasi berwarna ungu, garis hitam menunjukkan crisp output Centroid = 12.89):

![Arsitektur FIS: Hasil Implikasi, Agregasi, dan Defuzzifikasi Centroid](pipeline_fis_harga_rumah.png)

## F. Tugas Praktikum 7

**Kasus: Sistem Penentuan Harga Rumah**

```python
import numpy as np

# ==========================================================
# 1. DEFINISI FUNGSI KEANGGOTAAN
# ==========================================================

def trimf(x, params):
    """Fungsi keanggotaan segitiga [a, b, c]"""
    a, b, c = params

    if x <= a or x >= c:
        return 0.0
    elif x == b:
        return 1.0
    elif x < b:
        return (x - a) / (b - a)
    else:
        return (c - x) / (c - b)


def trapmf(x, params):
    """Fungsi keanggotaan trapesium [a, b, c, d]"""
    a, b, c, d = params

    x = np.asarray(x, dtype=float)
    y = np.zeros_like(x, dtype=float)

    # Bagian naik
    if a == b:
        y[x <= b] = 1.0
    else:
        idx1 = (x > a) & (x < b)
        y[idx1] = (x[idx1] - a) / (b - a)

    # Bagian datar
    y[(x >= b) & (x <= c)] = 1.0

    # Bagian turun
    if c == d:
        y[x >= c] = 1.0
    else:
        idx2 = (x > c) & (x < d)
        y[idx2] = (d - x[idx2]) / (d - c)

    hasil = np.clip(y, 0.0, 1.0)

    if hasil.ndim == 0:
        return float(hasil)

    return hasil


# ==========================================================
# 2. MEMBANGUN CLASS FUZZY INFERENCE SYSTEM
# ==========================================================
class FuzzyInferenceSystem:

    def __init__(self):
        self.input_variables = {}
        self.output_variable = None
        self.rules = []

    # Menambahkan variabel input
    def add_input_variable(self, name, universe, mf_dict):
        self.input_variables[name] = {
            "universe": universe,
            "mf": mf_dict
        }

    # Menentukan variabel output
    def set_output_variable(self, name, universe, mf_dict):
        self.output_variable = {
            "name": name,
            "universe": universe,
            "mf": mf_dict
        }

    # Menambahkan aturan fuzzy
    def add_rule(self, rule_tuple):
        self.rules.append(rule_tuple)

    # Menghitung hasil fuzzy
    def compute(self, input_values_dict):

        # --------------------------------------------------
        # A. FUZZIFIKASI
        # --------------------------------------------------
        fuzzifikasi = {}

        for nama, nilai in input_values_dict.items():
            fuzzifikasi[nama] = {}

            for kategori, fungsi in self.input_variables[nama]["mf"].items():
                fuzzifikasi[nama][kategori] = fungsi(nilai)

        # --------------------------------------------------
        # B. EVALUASI ATURAN DAN IMPLIKASI MIN
        # --------------------------------------------------
        z = self.output_variable["universe"]
        output_mf = self.output_variable["mf"]

        agregasi = np.zeros_like(z, dtype=float)

        for antecedent, consequent in self.rules:

            nilai_keanggotaan = []

            for nama_input, kategori in antecedent:
                nilai_keanggotaan.append(
                    fuzzifikasi[nama_input][kategori]
                )

            # Menghitung firing strength dengan MIN
            alpha = min(nilai_keanggotaan)

            # Implikasi Mamdani menggunakan MIN
            hasil_implikasi = np.minimum(
                alpha,
                output_mf[consequent]
            )

            # Agregasi menggunakan MAX
            agregasi = np.maximum(
                agregasi,
                hasil_implikasi
            )

        # --------------------------------------------------
        # C. DEFUZZIFIKASI CENTROID
        # --------------------------------------------------
        total_mu = np.sum(agregasi)

        if total_mu == 0:
            return 0.0

        z_crisp = np.sum(z * agregasi) / total_mu

        return z_crisp


# ==========================================================
# 3. MEMBUAT SISTEM PENENTUAN HARGA RUMAH
# ==========================================================
fis = FuzzyInferenceSystem()

# Input 1: Lokasi Rumah
fis.add_input_variable(
    "Lokasi",
    np.linspace(0, 50, 300),
    {
        "Sangat Strategis": lambda x: trapmf(x, [0, 0, 10, 20]),
        "Strategis": lambda x: trimf(x, [10, 25, 40]),
        "Tidak Strategis": lambda x: trapmf(x, [30, 40, 50, 50])
    }
)

# Input 2: Luas Tanah
fis.add_input_variable(
    "Luas Tanah",
    np.linspace(36, 200, 300),
    {
        "Kecil": lambda x: trapmf(x, [36, 36, 60, 100]),
        "Sedang": lambda x: trimf(x, [72, 120, 168]),
        "Luas": lambda x: trapmf(x, [140, 170, 200, 200])
    }
)

# Input 3: Luas Bangunan
fis.add_input_variable(
    "Luas Bangunan",
    np.linspace(21, 150, 300),
    {
        "Sempit": lambda x: trapmf(x, [21, 21, 36, 60]),
        "Sedang": lambda x: trimf(x, [45, 80, 115]),
        "Luas": lambda x: trapmf(x, [90, 115, 150, 150])
    }
)

# Output: Harga Rumah
z = np.linspace(1, 23, 300)

fis.set_output_variable(
    "Harga Rumah",
    z,
    {
        "Sangat Murah": trapmf(z, [1, 1, 3, 7]),
        "Murah": np.array([trimf(x, [3, 7, 11]) for x in z]),
        "Normal": np.array([trimf(x, [7, 11, 15]) for x in z]),
        "Mahal": np.array([trimf(x, [11, 15, 19]) for x in z]),
        "Sangat Mahal": trapmf(z, [15, 19, 23, 23])
    }
)


# ==========================================================
# 4. MEMASUKKAN 27 ATURAN FUZZY
# ==========================================================
lokasi = [
    "Sangat Strategis",
    "Strategis",
    "Tidak Strategis"
]

tanah = ["Kecil", "Sedang", "Luas"]
bangunan = ["Sempit", "Sedang", "Luas"]

# Output aturan R01 sampai R27
hasil_rule = [
    # R01 - R09: Sangat Strategis
    "Murah", "Normal", "Mahal",
    "Normal", "Mahal", "Sangat Mahal",
    "Mahal", "Sangat Mahal", "Sangat Mahal",

    # R10 - R18: Strategis
    "Sangat Murah", "Murah", "Normal",
    "Murah", "Normal", "Mahal",
    "Normal", "Mahal", "Sangat Mahal",

    # R19 - R27: Tidak Strategis
    "Sangat Murah", "Sangat Murah", "Murah",
    "Sangat Murah", "Murah", "Normal",
    "Murah", "Normal", "Mahal"
]

# Membentuk 27 aturan
nomor = 0

for l in lokasi:
    for t in tanah:
        for b in bangunan:

            rule = (
                (
                    ("Lokasi", l),
                    ("Luas Tanah", t),
                    ("Luas Bangunan", b)
                ),
                hasil_rule[nomor]
            )

            fis.add_rule(rule)
            nomor += 1


# ==========================================================
# 5. PENGUJIAN DENGAN 3 KOMBINASI INPUT
# ==========================================================
kasus_pengujian = {
    "Kasus 1": {
        "Lokasi": 5,
        "Luas Tanah": 50,
        "Luas Bangunan": 30
    },
    "Kasus 2": {
        "Lokasi": 15,
        "Luas Tanah": 120,
        "Luas Bangunan": 80
    },
    "Kasus 3": {
        "Lokasi": 25,
        "Luas Tanah": 150,
        "Luas Bangunan": 100
    }
}


# ==========================================================
# 6. MENAMPILKAN HASIL PREDIKSI HARGA RUMAH
# ==========================================================

print("HASIL SISTEM PENENTUAN HARGA RUMAH")
print("==========================================")

for nama_kasus, input_data in kasus_pengujian.items():

    hasil = fis.compute(input_data)

    harga_rumah = hasil * 100_000_000

    print(f"\n{nama_kasus}")
    print("Lokasi          :", input_data["Lokasi"])
    print("Luas Tanah      :", input_data["Luas Tanah"], "m2")
    print("Luas Bangunan   :", input_data["Luas Bangunan"], "m2")
    print("Nilai Centroid  :", round(hasil, 4))
    print("Estimasi Harga  : Rp{:,.0f}".format(harga_rumah))

print("\n==========================================")
print("Pengujian sistem selesai.")
```

**Output:**

```
HASIL SISTEM PENENTUAN HARGA RUMAH
==========================================

Kasus 1
Lokasi          : 5
Luas Tanah      : 50 m2
Luas Bangunan   : 30 m2
Nilai Centroid  : 7.0
Estimasi Harga  : Rp699,995,556

Kasus 2
Lokasi          : 15
Luas Tanah      : 120 m2
Luas Bangunan   : 80 m2
Nilai Centroid  : 13.359
Estimasi Harga  : Rp1,335,896,507

Kasus 3
Lokasi          : 25
Luas Tanah      : 150 m2
Luas Bangunan   : 100 m2
Nilai Centroid  : 15.1839
Estimasi Harga  : Rp1,518,392,539

==========================================
Pengujian sistem selesai.
```

## G. Pertanyaan Analisis

### 1. Mengapa FIS memerlukan tahap defuzzifikasi? Mengapa sistem kontrol atau pengambil keputusan tidak dapat langsung menggunakan fungsi keanggotaan agregasi fuzzy?

**Jawaban:**
FIS memerlukan defuzzifikasi karena hasil dari proses agregasi masih berbentuk nilai fuzzy atau derajat keanggotaan, bukan nilai angka pasti. Sistem kontrol atau pengambil keputusan membutuhkan nilai yang jelas agar bisa digunakan untuk menentukan suatu keputusan. Oleh karena itu, defuzzifikasi digunakan untuk mengubah hasil fuzzy menjadi nilai crisp (tegas).

### 2. Apa perbedaan utama antara metode implikasi Clipping (Min) dan Scaling (Product)? Bagaimana pengaruh masing-masing terhadap bentuk kurva agregasi?

**Jawaban:**
Perbedaannya terletak pada cara memotong atau mengubah fungsi keanggotaan berdasarkan nilai firing strength (α).

- **Clipping (Min)**: Menggunakan nilai minimum antara α dan derajat keanggotaan output. Akibatnya, bagian kurva yang nilainya lebih tinggi dari α akan terpotong rata pada tingkat α.
- **Scaling (Product)**: Mengalikan seluruh derajat keanggotaan output dengan nilai α. Akibatnya, tinggi kurva akan mengecil secara proporsional, tetapi bentuk asli kurva tetap dipertahankan.

Jadi, Clipping menghasilkan kurva dengan bagian atas yang terpotong, sedangkan Scaling menghasilkan kurva yang lebih rendah sesuai nilai α.

### 3. Jika pada tahap agregasi seluruh nilai α = 0, apa yang terjadi pada rumus Centroid ∑zμ / ∑μ? Bagaimana strategi penanganan kesalahan (fallback mechanism) yang tepat?

**Jawaban:**
Jika seluruh nilai α = 0, maka tidak ada aturan fuzzy yang aktif sehingga hasil agregasi memiliki derajat keanggotaan nol. Pada rumus Centroid, yaitu:

$$z^* = \frac{\sum z\,\mu(z)}{\sum \mu(z)}$$

nilai penyebut atau ∑μ(z) menjadi nol. Hal ini menyebabkan pembagian dengan nol sehingga nilai centroid tidak dapat dihitung.

## H. Kesimpulan

Fuzzy Inference System mengintegrasikan fuzzifikasi, rule base, implikasi, agregasi, dan defuzzifikasi menjadi satu kesatuan mesin inferensi yang utuh. Melalui arsitektur ini, input dunia nyata yang bersifat ambigu dapat diolah secara deterministik menjadi keputusan konkret yang dapat diimplementasikan pada aktuator, antarmuka pengguna, maupun modul sistem informasi.

---

*Laporan Praktikum Logika Fuzzy 2026 — Ruly Hajar Fauziah*
