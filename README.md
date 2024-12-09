## Kredencijali za pristup aplikacijama

### Setup Instructions

1. Open a terminal inside the solution folder.
2. Run the following commands:
- set STRIPE_SECRET_KEY=YourSecretKey
- docker-compose up -d --build


### Desktop Aplikacija (Rola: Admin)
- Korisničko ime: test
- Lozinka: test

### Desktop Aplikacija (Rola: Korisnik)
- Korisničko ime: guest
- Lozinka: guest

### Mobile Aplikacija

  #### Using Stripe Keys
  If you want to use your own Stripe keys, use the following commands:
   - flutter run --dart-define=STRIPE_PUBLISHABLE_KEY=YourPublishableKey
  
  #### Credentials:
    - Korisničko ime: test
    - Lozinka: test

### Mobile Aplikacija (Plaćanje)
 #### Kreditna kartica
  - Broj: 5555 5555 5555 4444
  - Datum: 03/27
  - CCV: 123

 #### PayPal
  - Email: cinebox@gmail.com
  - Password: C!neb0xx

### NOTE: Za "MailingService" potrebno izvršiti plaćanje u mobilnoj aplikaciji, nakon čega servis šalje mail potvrde plaćanja.

### Email za provjeru rada mailing servisa 
- Email: cineboxpetrovic@gmail.com
- Lozinka: C!neb0xPetrovic
