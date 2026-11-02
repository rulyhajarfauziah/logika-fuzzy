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
| **Topik** | Arsitektur Fuzzy Inference System (FIS) |
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
┌──────────────────────────────────────────────────────────────────────────────────┐
│                          FUZZY INFERENCE SYSTEM (FIS)                            │
│                                                                                  │
│   INPUT CRISP                                                    OUTPUT CRISP    │
│       │                                                               ▲          │
│       ▼                                                               │          │
│  ┌───────────┐         ┌─────────────────────┐                  ┌───────────┐    │
│  │           │         │  INFERENCE ENGINE   │                  │           │    │
│  │  FUZZI-   │ ──────► │  (Penalaran Aturan  │ ───────────────► │  DEFUZZI- │    │
│  │  FIKASI   │         │   dan Agregasi)     │                  │  FIKASI   │    │
│  └───────────┘         └─────────────────────┘                  └───────────┘    │
│                                   ▲                                              │
│                                   │                                              │
│                        ┌─────────────────────┐                                   │
│                        │   KNOWLEDGE BASE    │                                   │
│                        │   (Rule Base &      │                                   │
│                        │    Database MF)     │                                   │
│                        └─────────────────────┘                                   │
└──────────────────────────────────────────────────────────────────────────────────┘
```

1. **Basis Pengetahuan (*Knowledge Base*)**: Berisi definisi fungsi keanggotaan seluruh variabel (*Database*) dan kumpulan aturan IF-THEN (*Rule Base*).
2. **Unit Fuzzifikasi (*Fuzzification Interface*)**: Mengubah nilai input crisp menjadi derajat keanggotaan linguistik μ ∈ [0, 1].
3. **Mesin Inferensi (*Inference Engine*)**: Menerapkan operator logika fuzzy pada premis aturan, menerapkan metode implikasi (misal: pemotongan kurva/Mamdani Min), dan menggabungkan hasil seluruh aturan aktif ke dalam satu fungsi keanggotaan gabungan (*Aggregation*).
4. **Unit Defuzzifikasi (*Defuzzification Interface*)**: Mengubah daerah himpunan fuzzy hasil agregasi kembali menjadi satu nilai tegas (*crisp output*), misalnya melalui metode titik berat (*Centroid*).

## D. Alur Komputasi Step-by-Step

Diketahui sistem rekomendasi diskon layanan TI dengan input lama langganan 15 bulan dan frekuensi transaksi 8 kali per bulan.

- Input 1: x₁ = 15 bulan
- Input 2: x₂ = 8 kali/bulan
- Output: z = besaran diskon dalam persen

### Tahap 1: Fuzzifikasi

Fuzzifikasi adalah proses mengubah nilai input tegas (crisp) menjadi derajat keanggotaan fuzzy.

Diketahui:

- μ_Baru(15) = 0
- μ_Lama(15) = 0,75

Untuk frekuensi transaksi:

- μ_Jarang(8) = 0,20
- μ_Sering(8) = 0,80

Jadi, pelanggan memiliki derajat keanggotaan lama sebesar 0,75 dan derajat keanggotaan sering bertransaksi sebesar 0,80.

### Tahap 2: Evaluasi Aturan dan Implikasi

Pada tahap ini, nilai keanggotaan input digunakan untuk menghitung kekuatan aturan (firing strength) dengan operator AND berupa minimum (MIN).

**Rule 1**

IF Lama Langganan Lama AND Frekuensi Jarang THEN Diskon Sedang.

α₁ = min(0,75; 0,20) = 0,20

Artinya, aturan pertama aktif dengan kekuatan 0,20. Fungsi keanggotaan diskon sedang dipotong pada ketinggian 0,20.

**Rule 2**

IF Lama Langganan Lama AND Frekuensi Sering THEN Diskon Besar.

α₂ = min(0,75; 0,80) = 0,75

Artinya, aturan kedua aktif dengan kekuatan 0,75. Fungsi keanggotaan diskon besar dipotong pada ketinggian 0,75.

### Tahap 3: Agregasi dengan Operator MAX

Agregasi adalah proses menggabungkan hasil implikasi dari seluruh aturan aktif menggunakan nilai maksimum.

Rumusnya:

$$\mu_{Agg}(z) = \max\left(\mu'_{Sedang}(z),\ \mu'_{Besar}(z)\right)$$

Dengan:

$$\mu'_{Sedang}(z) = \min(0{,}20,\ \mu_{Sedang}(z))$$

$$\mu'_{Besar}(z) = \min(0{,}75,\ \mu_{Besar}(z))$$

Hasilnya adalah satu kurva fuzzy gabungan yang mencakup diskon sedang dan diskon besar. Kurva inilah yang digunakan pada proses defuzzifikasi.

### Tahap 4: Defuzzifikasi dengan Metode Centroid

Defuzzifikasi bertujuan mengubah hasil agregasi fuzzy menjadi satu nilai diskon tegas (crisp output).

Rumus centroid untuk data kontinu:

$$z^* = \frac{\int z\, \mu_{Agg}(z)\, dz}{\int \mu_{Agg}(z)\, dz}$$

Jika dihitung menggunakan sejumlah titik diskret, rumus pendekatannya:

$$z^* \approx \frac{\sum_i z_i\, \mu_{Agg}(z_i)}{\sum_i \mu_{Agg}(z_i)}$$

Keterangan:

- z*: nilai diskon akhir dalam persen.
- zᵢ: titik nilai diskon yang dihitung.
- μ_Agg(zᵢ): derajat keanggotaan hasil agregasi pada titik tersebut.

## E. Implementasi Program Python

```python
import numpy as np
import matplotlib.pyplot as plt

# ==========================================================
# 1. FUNGSI DEFUZZIFIKASI CENTROID
# ==========================================================
def defuzzifikasi_centroid(x_vals, mu_vals):
    total_mu = np.sum(mu_vals)

    if total_mu == 0:
        return 0.0

    return np.sum(x_vals * mu_vals) / total_mu


# ==========================================================
# 2. MENENTUKAN INPUT PENGUJIAN
# ==========================================================
input_pengujian = {
    "Lama Langganan": 12,
    "Frekuensi Transaksi": 6
}

# ==========================================================
# 3. MEMBANGUN MODEL FUZZY INFERENCE SYSTEM
# ==========================================================
def trimf(x, params):
    a, b, c = params
    y = np.zeros_like(x, dtype=float)

    if b != a:
        idx = (x > a) & (x <= b)
        y[idx] = (x[idx] - a) / (b - a)

    if c != b:
        idx = (x > b) & (x < c)
        y[idx] = (c - x[idx]) / (c - b)

    y[x == b] = 1

    return np.clip(y, 0, 1)


def trapmf(x, params):
    a, b, c, d = params
    y = np.zeros_like(x, dtype=float)

    if b != a:
        idx = (x >= a) & (x < b)
        y[idx] = (x[idx] - a) / (b - a)

    idx = (x >= b) & (x <= c)
    y[idx] = 1

    if d != c:
        idx = (x > c) & (x <= d)
        y[idx] = (d - x[idx]) / (d - c)

    return np.clip(y, 0, 1)


class FuzzyInferenceSystem:

    def __init__(self):
        self.input_variables = {}
        self.output_variable = None
        self.rules = []

    def add_input_variable(self, name, universe, mf_dict):
        self.input_variables[name] = {
            "universe": universe,
            "mf": mf_dict
        }

    def set_output_variable(self, name, universe, mf_dict):
        self.output_variable = {
            "name": name,
            "universe": universe,
            "mf": mf_dict
        }

    def add_rule(self, rule_tuple):
        self.rules.append(rule_tuple)

    # Proses fuzzifikasi, inferensi, implikasi, dan agregasi
    def compute_details(self, input_values_dict):

        memberships = {}

        # Fuzzifikasi
        for name, value in input_values_dict.items():
            variable = self.input_variables[name]

            memberships[name] = {
                label: np.interp(
                    value,
                    variable["universe"],
                    mf
                )
                for label, mf in variable["mf"].items()
            }

        output = self.output_variable
        universe = output["universe"]

        aggregated = np.zeros_like(universe)
        firing_strengths = []

        # Evaluasi aturan fuzzy
        for lama_set, frekuensi_set, diskon_set in self.rules:

            alpha = min(
                memberships["Lama Langganan"][lama_set],
                memberships["Frekuensi Transaksi"][frekuensi_set]
            )

            firing_strengths.append(alpha)

            # Implikasi menggunakan MIN
            implied = np.minimum(
                alpha,
                output["mf"][diskon_set]
            )

            # Agregasi menggunakan MAX
            aggregated = np.maximum(
                aggregated,
                implied
            )

        # Memeriksa apakah ada aturan yang aktif
        if np.sum(aggregated) == 0:
            raise ValueError(
                "Tidak ada aturan fuzzy yang aktif!"
            )

        # Defuzzifikasi centroid
        crisp_output = defuzzifikasi_centroid(
            universe,
            aggregated
        )

        return crisp_output, firing_strengths, aggregated

    # Mengembalikan nilai crisp output
    def compute(self, input_values_dict):
        crisp_output, _, _ = self.compute_details(
            input_values_dict
        )
        return crisp_output


# ==========================================================
# 4. MENENTUKAN UNIVERSE DAN FUNGSI KEANGGOTAAN
# ==========================================================
universe_lama = np.linspace(0, 24, 241)
universe_frekuensi = np.linspace(0, 15, 151)
universe_diskon = np.linspace(0, 30, 301)

mf_lama = {
    "Pendek": trapmf(universe_lama, [0, 0, 3, 9]),
    "Sedang": trimf(universe_lama, [3, 12, 21]),
    "Lama": trapmf(universe_lama, [15, 21, 24, 24])
}

mf_frekuensi = {
    "Rendah": trapmf(universe_frekuensi, [0, 0, 2, 6]),
    "Sedang": trimf(universe_frekuensi, [3, 7.5, 12]),
    "Tinggi": trapmf(universe_frekuensi, [9, 13, 15, 15])
}

mf_diskon = {
    "Rendah": trapmf(universe_diskon, [0, 0, 5, 12]),
    "Sedang": trimf(universe_diskon, [8, 15, 22]),
    "Tinggi": trapmf(universe_diskon, [18, 25, 30, 30])
}

# ==========================================================
# 5. MEMBANGUN SISTEM DAN MENAMBAHKAN RULE
# ==========================================================
fis = FuzzyInferenceSystem()

fis.add_input_variable(
    "Lama Langganan",
    universe_lama,
    mf_lama
)

fis.add_input_variable(
    "Frekuensi Transaksi",
    universe_frekuensi,
    mf_frekuensi
)

fis.set_output_variable(
    "Diskon",
    universe_diskon,
    mf_diskon
)

rules = [
    ("Pendek", "Rendah", "Rendah"),
    ("Pendek", "Sedang", "Rendah"),
    ("Pendek", "Tinggi", "Sedang"),
    ("Sedang", "Rendah", "Rendah"),
    ("Sedang", "Sedang", "Sedang"),
    ("Sedang", "Tinggi", "Tinggi"),
    ("Lama", "Rendah", "Sedang"),
    ("Lama", "Sedang", "Tinggi"),
    ("Lama", "Tinggi", "Tinggi")
]

for rule in rules:
    fis.add_rule(rule)

# ==========================================================
# 6. PROSES FUZZY INFERENCE SYSTEM
# ==========================================================
crisp = fis.compute(input_pengujian)

_, firing, agregasi = fis.compute_details(
    input_pengujian
)

z = universe_diskon

print("HASIL PIPELINE FUZZY INFERENCE SYSTEM")
print("=" * 45)

for i, alpha in enumerate(firing, start=1):
    print(f"R{i}: α = {alpha:.4f}")

print("-" * 45)
print(f"Nilai Crisp Output : {crisp:.2f}%")
print(f"Rekomendasi Diskon : {crisp:.2f}%")

# ==========================================================
# 7. VISUALISASI FUNGSI KEANGGOTAAN OUTPUT
# ==========================================================
plt.figure(figsize=(12, 6))

plt.plot(
    z,
    mf_diskon["Rendah"],
    'g--',
    label='Diskon Rendah',
    alpha=0.6
)

plt.plot(
    z,
    mf_diskon["Sedang"],
    'b--',
    label='Diskon Sedang',
    alpha=0.6
)

plt.plot(
    z,
    mf_diskon["Tinggi"],
    'r--',
    label='Diskon Tinggi',
    alpha=0.6
)

# ==========================================================
# 8. VISUALISASI IMPLIKASI DAN AGREGASI
# ==========================================================
plt.fill_between(
    z,
    0,
    agregasi,
    color='purple',
    alpha=0.35,
    label='Daerah Agregasi Fuzzy'
)

plt.plot(
    z,
    agregasi,
    color='purple',
    linewidth=2.5
)

# ==========================================================
# 9. GARIS CENTROID
# ==========================================================
plt.axvline(
    x=crisp,
    color='black',
    linewidth=2.5,
    label=f'Centroid = {crisp:.2f}%'
)

plt.scatter(
    [crisp],
    [0],
    color='black',
    s=80,
    zorder=6
)

# ==========================================================
# 10. PENGATURAN GRAFIK
# ==========================================================
plt.title(
    'Pipeline FIS: Implikasi, Agregasi, dan Defuzzifikasi Centroid',
    fontsize=13,
    fontweight='bold'
)

plt.xlabel('Besaran Diskon (%)', fontsize=11)
plt.ylabel('Derajat Keanggotaan μ(z)', fontsize=11)

plt.xlim(0, 30)
plt.ylim(-0.05, 1.05)

plt.grid(True, linestyle=':', alpha=0.6)
plt.legend(loc='upper left', fontsize=10)

plt.tight_layout()

plt.savefig(
    'pipeline_fis_agregasi_defuzzifikasi.png',
    dpi=300
)

plt.show()

# ==========================================================
# 11. KESIMPULAN HASIL SISTEM
# ==========================================================
print("\nKeputusan Akhir Sistem FIS:")
print(f"Rekomendasi Diskon: {crisp:.2f}%")
```

**Output:**

```
HASIL PIPELINE FUZZY INFERENCE SYSTEM
=============================================
R1: α = 0.0000
R2: α = 0.0000
R3: α = 0.0000
R4: α = 0.0000
R5: α = 0.6667
R6: α = 0.0000
R7: α = 0.0000
R8: α = 0.0000
R9: α = 0.0000
---------------------------------------------
Nilai Crisp Output : 15.00%
Rekomendasi Diskon : 15.00%

Keputusan Akhir Sistem FIS:
Rekomendasi Diskon: 15.00%
```

Grafik implikasi, agregasi, dan defuzzifikasi Centroid (daerah agregasi berwarna ungu, garis hitam menunjukkan Centroid = 15,00%):

![Pipeline FIS: Implikasi, Agregasi, dan Defuzzifikasi Centroid](pipeline_fis_agregasi_defuzzifikasi.png)

## F. Tugas Praktikum 7

**Menggabungkan Fuzzifikasi, Evaluasi Aturan, dan Defuzzifikasi Menjadi Satu Fungsi Utuh**

```python
import numpy as np
import matplotlib.pyplot as plt

# ==========================================================
# 1. FUNGSI KEANGGOTAAN SEGITIGA DAN TRAPESIUM
# ==========================================================
def trimf(x, params):
    a, b, c = params
    y = np.zeros_like(x, dtype=float)

    if b != a:
        idx = (x > a) & (x <= b)
        y[idx] = (x[idx] - a) / (b - a)

    if c != b:
        idx = (x > b) & (x < c)
        y[idx] = (c - x[idx]) / (c - b)

    y[x == b] = 1

    return np.clip(y, 0, 1)


def trapmf(x, params):
    a, b, c, d = params
    y = np.zeros_like(x, dtype=float)

    if b != a:
        idx = (x >= a) & (x < b)
        y[idx] = (x[idx] - a) / (b - a)

    idx = (x >= b) & (x <= c)
    y[idx] = 1

    if d != c:
        idx = (x > c) & (x <= d)
        y[idx] = (d - x[idx]) / (d - c)

    return np.clip(y, 0, 1)


# ==========================================================
# 2. MEMBANGUN KELAS FUZZY INFERENCE SYSTEM
# ==========================================================
class FuzzyInferenceSystem:

    def __init__(self):
        self.input_variables = {}
        self.output_variable = None
        self.rules = []

    def add_input_variable(self, name, universe, mf_dict):
        self.input_variables[name] = {
            "universe": universe,
            "mf": mf_dict
        }

    def set_output_variable(self, name, universe, mf_dict):
        self.output_variable = {
            "name": name,
            "universe": universe,
            "mf": mf_dict
        }

    def add_rule(self, rule_tuple):
        self.rules.append(rule_tuple)

    # PROSES PERHITUNGAN FIS SECARA LENGKAP
    def compute_details(self, input_values_dict):

        # FUZZIFIKASI
        memberships = {}

        for name, value in input_values_dict.items():
            variable = self.input_variables[name]

            memberships[name] = {
                label: np.interp(
                    value,
                    variable["universe"],
                    mf
                )
                for label, mf in variable["mf"].items()
            }

        # IMPLIKASI DAN AGREGASI
        output = self.output_variable
        universe = output["universe"]

        aggregated = np.zeros_like(universe)
        firing_strengths = []

        for rule in self.rules:
            lama_set, frekuensi_set, diskon_set = rule

            # Evaluasi aturan menggunakan MIN
            alpha = min(
                memberships["Lama Langganan"][lama_set],
                memberships["Frekuensi Transaksi"][frekuensi_set]
            )

            firing_strengths.append(alpha)

            # Implikasi Mamdani MIN
            implied = np.minimum(
                alpha,
                output["mf"][diskon_set]
            )

            # Agregasi MAX
            aggregated = np.maximum(
                aggregated,
                implied
            )

        # DEFUZZIFIKASI CENTROID
        total = np.sum(aggregated)

        if total == 0:
            raise ValueError("Tidak ada aturan fuzzy yang aktif.")

        crisp_output = np.sum(
            universe * aggregated
        ) / total

        return crisp_output, firing_strengths, aggregated

    # FUNGSI COMPUTE SESUAI INSTRUKSI PRAKTIKUM
    def compute(self, input_values_dict):
        crisp_output, _, _ = self.compute_details(input_values_dict)
        return crisp_output


# ==========================================================
# 3. MENENTUKAN DOMAIN VARIABEL
# ==========================================================
universe_lama = np.linspace(0, 24, 241)
universe_frekuensi = np.linspace(0, 15, 151)
universe_diskon = np.linspace(0, 30, 301)

# ==========================================================
# 4. FUNGSI KEANGGOTAAN INPUT
# ==========================================================
mf_lama = {
    "Pendek": trapmf(universe_lama, [0, 0, 3, 9]),
    "Sedang": trimf(universe_lama, [3, 12, 21]),
    "Lama": trapmf(universe_lama, [15, 21, 24, 24])
}

mf_frekuensi = {
    "Rendah": trapmf(universe_frekuensi, [0, 0, 2, 6]),
    "Sedang": trimf(universe_frekuensi, [3, 7.5, 12]),
    "Tinggi": trapmf(universe_frekuensi, [9, 13, 15, 15])
}

# ==========================================================
# 5. FUNGSI KEANGGOTAAN OUTPUT DISKON
# ==========================================================
mf_diskon = {
    "Rendah": trapmf(universe_diskon, [0, 0, 5, 12]),
    "Sedang": trimf(universe_diskon, [8, 15, 22]),
    "Tinggi": trapmf(universe_diskon, [18, 25, 30, 30])
}

# ==========================================================
# 6. MEMBUAT OBJEK SISTEM FUZZY
# ==========================================================
fis = FuzzyInferenceSystem()

fis.add_input_variable(
    "Lama Langganan",
    universe_lama,
    mf_lama
)

fis.add_input_variable(
    "Frekuensi Transaksi",
    universe_frekuensi,
    mf_frekuensi
)

fis.set_output_variable(
    "Diskon",
    universe_diskon,
    mf_diskon
)

# ==========================================================
# 7. MENAMBAHKAN 9 ATURAN FUZZY
# ==========================================================
rules = [
    ("Pendek", "Rendah", "Rendah"),
    ("Pendek", "Sedang", "Rendah"),
    ("Pendek", "Tinggi", "Sedang"),
    ("Sedang", "Rendah", "Rendah"),
    ("Sedang", "Sedang", "Sedang"),
    ("Sedang", "Tinggi", "Tinggi"),
    ("Lama", "Rendah", "Sedang"),
    ("Lama", "Sedang", "Tinggi"),
    ("Lama", "Tinggi", "Tinggi")
]

for rule in rules:
    fis.add_rule(rule)

# ==========================================================
# 8. TIGA KASUS PENGUJIAN
# ==========================================================
kasus = [
    {"Lama Langganan": 3, "Frekuensi Transaksi": 2},
    {"Lama Langganan": 12, "Frekuensi Transaksi": 6},
    {"Lama Langganan": 24, "Frekuensi Transaksi": 15}
]

# ==========================================================
# 9. MENAMPILKAN HASIL DAN GRAFIK SETIAP KASUS
# ==========================================================
for nomor, data in enumerate(kasus, start=1):

    # Mengambil nilai crisp melalui compute()
    crisp = fis.compute(data)

    # Mengambil detail perhitungan untuk grafik
    _, firing, aggregated = fis.compute_details(data)

    lama = data["Lama Langganan"]
    frekuensi = data["Frekuensi Transaksi"]

    # Derajat keanggotaan input
    mu_lama = {
        label: np.interp(lama, universe_lama, mf)
        for label, mf in mf_lama.items()
    }

    mu_frekuensi = {
        label: np.interp(frekuensi, universe_frekuensi, mf)
        for label, mf in mf_frekuensi.items()
    }

    # Membuat grafik 2 x 2
    fig, ax = plt.subplots(2, 2, figsize=(14, 9))

    fig.suptitle(
        f"FIS Mamdani - Pengujian Kasus {nomor}",
        fontsize=15,
        fontweight="bold"
    )

    # GRAFIK 1: LAMA LANGGANAN
    for label, mf in mf_lama.items():
        ax[0, 0].plot(
            universe_lama, mf,
            label=label, linewidth=2
        )

    ax[0, 0].axvline(
        lama, color="red", linestyle="--",
        label=f"Input = {lama}"
    )

    ax[0, 0].set_title("Variabel Input: Lama Langganan")
    ax[0, 0].set_xlabel("Lama Langganan (bulan)")
    ax[0, 0].set_ylabel("Derajat Keanggotaan")
    ax[0, 0].set_ylim(0, 1.1)
    ax[0, 0].grid(True, alpha=0.4)
    ax[0, 0].legend()

    # GRAFIK 2: FREKUENSI TRANSAKSI
    for label, mf in mf_frekuensi.items():
        ax[0, 1].plot(
            universe_frekuensi, mf,
            label=label, linewidth=2
        )

    ax[0, 1].axvline(
        frekuensi, color="red", linestyle="--",
        label=f"Input = {frekuensi}"
    )

    ax[0, 1].set_title("Variabel Input: Frekuensi Transaksi")
    ax[0, 1].set_xlabel("Frekuensi Transaksi (kali)")
    ax[0, 1].set_ylabel("Derajat Keanggotaan")
    ax[0, 1].set_ylim(0, 1.1)
    ax[0, 1].grid(True, alpha=0.4)
    ax[0, 1].legend()

    # GRAFIK 3: OUTPUT, AGREGASI, DAN CENTROID
    for label, mf in mf_diskon.items():
        ax[1, 0].plot(
            universe_diskon, mf,
            linestyle="--", alpha=0.5,
            label=f"MF {label}"
        )

    ax[1, 0].fill_between(
        universe_diskon, 0, aggregated,
        color="green", alpha=0.35,
        label="Agregasi MAX"
    )

    ax[1, 0].plot(
        universe_diskon, aggregated,
        color="green", linewidth=2
    )

    ax[1, 0].axvline(
        crisp, color="black", linewidth=2.5,
        label=f"Centroid = {crisp:.2f}%"
    )

    ax[1, 0].set_title("Output Diskon dan Daerah Agregasi")
    ax[1, 0].set_xlabel("Besaran Diskon (%)")
    ax[1, 0].set_ylabel("Derajat Keanggotaan")
    ax[1, 0].set_xlim(0, 30)
    ax[1, 0].set_ylim(0, 1.1)
    ax[1, 0].grid(True, alpha=0.4)
    ax[1, 0].legend(fontsize=8)

    # GRAFIK 4: FIRING STRENGTH SETIAP ATURAN
    ax[1, 1].bar(
        range(1, 10),
        firing,
        color="seagreen"
    )

    ax[1, 1].set_title("Nilai Firing Strength (α) Tiap Aturan")
    ax[1, 1].set_xlabel("Nomor Aturan")
    ax[1, 1].set_ylabel("Nilai Firing Strength")
    ax[1, 1].set_xticks(range(1, 10))
    ax[1, 1].set_ylim(0, 1.1)
    ax[1, 1].grid(axis="y", alpha=0.4)

    for i, nilai in enumerate(firing):
        ax[1, 1].text(
            i + 1, nilai + 0.025,
            f"{nilai:.2f}",
            ha="center", fontsize=8
        )

    plt.tight_layout(rect=[0, 0, 1, 0.95])

    plt.savefig(
        f"hasil_kasus_{nomor}.png",
        dpi=300
    )

    plt.show()

    # MENAMPILKAN HASIL
    print("=" * 55)
    print(f"HASIL PENGUJIAN KASUS {nomor}")
    print(f"Lama Langganan      : {lama} bulan")
    print(f"Frekuensi Transaksi : {frekuensi} kali")
    print(f"Diskon              : {crisp:.2f}%")
    print("\nNilai Firing Strength:")

    for i, alpha in enumerate(firing, start=1):
        print(f"R{i}: α = {alpha:.4f}")

print("=" * 55)
print("SELURUH PENGUJIAN SELESAI")
```

**Output Kasus 1:**

```
=======================================================
HASIL PENGUJIAN KASUS 1
Lama Langganan      : 3 bulan
Frekuensi Transaksi : 2 kali
Diskon              : 4.46%

Nilai Firing Strength:
R1: α = 1.0000
R2: α = 0.0000
R3: α = 0.0000
R4: α = 0.0000
R5: α = 0.0000
R6: α = 0.0000
R7: α = 0.0000
R8: α = 0.0000
R9: α = 0.0000
```

![FIS Mamdani - Pengujian Kasus 1](hasil_kasus_1.png)

**Output Kasus 2:**

```
=======================================================
HASIL PENGUJIAN KASUS 2
Lama Langganan      : 12 bulan
Frekuensi Transaksi : 6 kali
Diskon              : 15.00%

Nilai Firing Strength:
R1: α = 0.0000
R2: α = 0.0000
R3: α = 0.0000
R4: α = 0.0000
R5: α = 0.6667
R6: α = 0.0000
R7: α = 0.0000
R8: α = 0.0000
R9: α = 0.0000
```

![FIS Mamdani - Pengujian Kasus 2](hasil_kasus_2.png)

**Output Kasus 3:**

```
=======================================================
HASIL PENGUJIAN KASUS 3
Lama Langganan      : 24 bulan
Frekuensi Transaksi : 15 kali
Diskon              : 25.54%

Nilai Firing Strength:
R1: α = 0.0000
R2: α = 0.0000
R3: α = 0.0000
R4: α = 0.0000
R5: α = 0.0000
R6: α = 0.0000
R7: α = 0.0000
R8: α = 0.0000
R9: α = 1.0000
```

![FIS Mamdani - Pengujian Kasus 3](hasil_kasus_3.png)

### Hasil Pengujian

Pengujian dilakukan menggunakan tiga kombinasi input yang sudah ditentukan dalam instruksi praktikum.

| Kasus | Lama Langganan | Frekuensi Transaksi | Hasil Diskon |
|---|---|---|---|
| 1 | 3 bulan | 2 kali | 4,46% |
| 2 | 12 bulan | 6 kali | 15,00% |
| 3 | 24 bulan | 15 kali | 25,54% |

Hasil tersebut diperoleh dengan metode centroid diskrit pada domain diskon 0–30 dengan 301 titik sampel.

### Analisis Hasil

Pada kasus pertama, pelanggan memiliki lama langganan 3 bulan dan frekuensi transaksi sebanyak 2 kali. Kedua input tersebut termasuk dalam himpunan Pendek dan Rendah dengan derajat keanggotaan 1. Sistem menghasilkan diskon sebesar 4,46%.

Pada kasus kedua, pelanggan memiliki lama langganan 12 bulan dan frekuensi transaksi sebanyak 6 kali. Nilai tersebut termasuk dalam himpunan Sedang dengan derajat keanggotaan 1 untuk lama langganan dan sekitar 0,67 untuk frekuensi transaksi. Sistem menghasilkan diskon sebesar 15,00%.

Pada kasus ketiga, pelanggan memiliki lama langganan 24 bulan dan frekuensi transaksi sebanyak 15 kali. Kedua input termasuk dalam himpunan Lama dan Tinggi dengan derajat keanggotaan 1. Sistem menghasilkan diskon sebesar 25,54%.

Berdasarkan hasil tersebut, nilai diskon meningkat pada ketiga kasus pengujian. Hal ini sesuai dengan aturan yang telah dibuat, yaitu pelanggan dengan masa langganan lebih lama dan frekuensi transaksi lebih tinggi memperoleh rekomendasi diskon yang lebih besar.

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
