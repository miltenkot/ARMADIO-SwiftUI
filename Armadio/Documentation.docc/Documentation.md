# ``Armadio``

The application helps you manage your wardrobe. It allows you to add clothes and their properties as well as display statistics, and receipts and add currently worn clothes. The application has user authorization via **email** and **password** or **google sign in**.

## Overview

The application is written in SwiftUI using the MVVM architecture. It uses the **Factory** library to manage dependencies and **ViewInspector** library for views unit tests.

## Topics

### Model

- ``Clothe``
- ``Price``
- ``Category``
- ``Subcategory``
- ``Receipt``
- ``Stats``
- ``UserInfo``
- ``LocalClothe``
- ``LocalCategory``
- ``LocalSubcategory``
- ``LocalPrice``
- ``LocalReceipt``
- ``ClotheCategory``

### Service

- ``CountryFlagProviderImpl``
- ``FirebaseAnaliticsProviderImpl``
- ``ClotheDataProviderImpl``
- ``GoogleSignInAuthProviderImpl``
- ``FirebaseAuthService``
