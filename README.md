# 📸 Sistem de Gestionare și Monitorizare a Evenimentelor Foto-Video

## 📖 Descriere
Acest proiect reprezintă o bază de date pentru gestionarea eficientă a evenimentelor foto-video. 
Sistemul este conceput pentru a ajuta organizatorii să monitorizeze clienții, locațiile, colaboratorii și materialele media 
asociate evenimentelor, oferind o platformă centralizată pentru administrare.

### 🔹 Funcționalități principale:
- 📌 **Gestionarea clienților**: Stocarea informațiilor despre clienți (nume, telefon, email, adresă).
- 🎉 **Administrarea evenimentelor**: Monitorizarea detaliilor unui eveniment (tip, dată, locație, colaboratori, materiale).
- 📍 **Gestionarea locațiilor**: Stocarea locațiilor utilizate pentru evenimente și asocierea lor cu diferite evenimente.
- 🤝 **Colaboratori**: Administrarea fotografilor, videografilor și altor colaboratori implicați.
- 🖼️ **Stocarea materialelor**: Fotografii și videoclipuri asociate fiecărui eveniment.
- 📊 **Generarea de rapoarte**: Calcularea veniturilor, costurilor și profitului net.

---

## 🏛️ Structura bazei de date
Baza de date include următoarele tabele:
1. **Clienti** - Informații despre clienți.
2. **Colaboratori** - Detalii despre partenerii implicați.
3. **Evenimente** - Evenimente organizate.
4. **Locatii** - Locațiile disponibile.
5. **Colaboratori_Eveniment** - Relația Many-to-Many între colaboratori și evenimente.
6. **Locatii_Eveniment** - Relația Many-to-Many între locații și evenimente.
7. **Materiale** - Fișiere foto/video asociate fiecărui eveniment.

---

## ⚙️ Implementare
- 📜 **Fișier DDL**: `creareTabele.ddl` – Definirea tabelelor și a relațiilor.
- 💾 **Inserare date**: `inserareDateTest.sql` – Script pentru popularea bazei de date.
- ✅ **Validare**: `validare.sql` – Script pentru verificarea corectitudinii datelor.
- 📊 **Vizualizare**: `vizualizare.sql` – Interogări utile pentru afișarea datelor.
- 🔄 **Use-case-uri implementate:**
  - 📝 `useCase1.sql` - Adăugare Client
  - 📝 `useCase2.sql` - Adăugare Eveniment
  - 📝 `useCase3.sql` - Finalizarea unui Eveniment
  - 📝 `useCase4.sql` - Anularea unui Eveniment
  - 📝 `useCase5.sql` - Actualizare Date Client
  - 📝 `useCase6.sql` - Afișarea Evenimentelor Viitoare ale unui Client
  - 📝 `useCase7.sql` - Calcularea Venitului Total din Evenimente

### 🔍 Normalizare:
- **1NF** - Eliminarea grupurilor de atribute redundante.
- **2NF** - Toate atributele depind de cheia primară.
- **3NF** - Nu există dependențe tranzitive.
- **4NF & 5NF** - Gestionarea relațiilor Many-to-Many prin tabele intermediare.

---

## 👤 Autor
👨‍💻 **Alin-Ionuț Sfichi**  
📧 alinalinsfichi@gmail.com  
🎓 **Facultatea de Automatică și Calculatoare, Universitatea Tehnică „Gheorghe Asachi” Iași**  

---

🚀 *Proiect realizat pentru disciplina Baze de Date - 2024*
