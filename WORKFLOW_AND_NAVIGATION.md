# Fixteck App - Workflow and Navigation Documentation

## Overview
This document describes the complete workflow and page navigation structure of the Fixteck mobile application. The app is a service booking platform that allows users to book various home services like Plumbing, Electrical, Cleaning, etc.

## App Architecture

### Main Entry Point
- **File**: `lib/main.dart`
- **Initial Screen**: `SplashScreen`
- **State Management**: Uses BLoC pattern with `flutter_bloc`
- **Repositories**: 
  - `AuthRepository` - Authentication
  - `WalletRepository` - Wallet operations
  - `ProfileRepository` - User profile

## Navigation Flow

### 1. App Initialization Flow

```
SplashScreen
    ↓
    ├─→ OnboardingPage (if first time)
    │       ↓
    │   LoginPage
    │
    ├─→ LoginPage (if no token)
    │
    └─→ HomePage (if authenticated)
```

**Details:**
- `SplashScreen` checks:
  1. If onboarding is completed
  2. If user has authentication token
  3. Navigates accordingly

### 2. Authentication Flow

```
LoginPage
    ↓ (Enter phone number)
OTPPage
    ↓ (Enter OTP)
HomePage
```

**Files:**
- `lib/ui/login/login_page.dart` - Phone number input
- `lib/ui/login/otp_page.dart` - OTP verification
- Uses `LoginBloc` for state management
- Stores token via `StorageService`

### 3. Main Navigation (Bottom Navigation Bar)

```
HomePage (Bottom Nav Bar)
    ├─→ HomeContent (Tab 0) - Home screen with services
    ├─→ BookingsPage (Tab 1) - User's bookings
    └─→ AccountPage (Tab 2) - User account/profile
```

**File**: `lib/ui/home/home_pagefun.dart`
- Uses `BottomNavBar` for tab navigation
- Each tab is a separate screen

### 4. Service Booking Flow

This is the main workflow for booking a service:

```
HomeContent
    ↓ (Tap on service card)
ServiceDetailsScreen
    ↓ (Select service category from grid)
ServiceSelectionBottomSheet
    ↓ (Tap "Continue" button)
ServicePage
    ↓ (Select date/time)
SelectDateAndTimePage
    ↓ (Returns selected date/time)
ServicePage
    ↓ (Edit address if needed)
SelectAddressPage
    ↓ (Returns address data)
ServicePage
    ↓ (Tap "Continue Booking" button)
BookingConfrimScreen ← **NEWLY IMPLEMENTED**
    ↓ (Confirm booking)
[Booking Confirmation/Order Placed]
```

#### Detailed Step-by-Step:

**Step 1: Home Screen → Service Details**
- **From**: `lib/ui/home/home_page.dart` (HomeContent)
- **To**: `lib/ui/servicedetails/service_details_screen.dart`
- **Action**: User taps on a service card (e.g., Plumbing, Electrical)
- **Data Passed**: `serviceName` (e.g., "Plumbing")

**Step 2: Service Details → Service Selection**
- **From**: `ServiceDetailsScreen`
- **To**: `ServiceSelectionBottomSheet` (Modal Bottom Sheet)
- **Action**: User taps on a service category (e.g., "Toilet", "Bath & Shower")
- **Data Passed**: `title` (category name)

**Step 3: Service Selection → Service Page**
- **From**: `ServiceSelectionBottomSheet`
- **To**: `lib/ui/bookings/service/service_page.dart`
- **Action**: User taps "Continue" button in bottom sheet
- **Data Passed**: Service category information

**Step 4: Select Date & Time**
- **From**: `ServicePage`
- **To**: `lib/ui/bookings/select_date_time_page.dart`
- **Action**: User taps on date/time field
- **Returns**: `Map<String, dynamic>` with `dateTime` key
- **Data**: Selected `DateTime` object

**Step 5: Select/Edit Address**
- **From**: `ServicePage`
- **To**: `lib/ui/bookings/select_address_page.dart`
- **Action**: User taps edit icon next to address
- **Returns**: `Map<String, dynamic>` with address fields:
  - `name` - Contact name
  - `building` - Building/Villa name
  - `address` - Full address
  - `phone` - Contact number

**Step 6: Booking Confirmation**
- **From**: `ServicePage`
- **To**: `lib/ui/bookingconfirm/booking_confrim_screen.dart` ← **NEWLY IMPLEMENTED**
- **Action**: User taps "Continue Booking" button
- **Data Passed**:
  - `serviceName`: String (e.g., "Plumbing")
  - `serviceType`: String (e.g., "PLUMBER")
  - `scheduledDate`: DateTime? (selected date)
  - `scheduledTime`: String? (formatted time range, e.g., "10:00 AM - 12:00 PM")
  - `addressName`: String (contact name)
  - `buildingName`: String (building/villa name)
  - `fullAddress`: String (complete address)
  - `phoneNumber`: String (contact number)
  - `serviceInformation`: String (service details)

### 5. Booking Confirmation Screen Features

The `BookingConfrimScreen` displays:

1. **Service Details Card**
   - Service Name
   - Scheduled Date
   - Scheduled Time
   - Service Information

2. **Address Card**
   - Contact name
   - Building name
   - Full address
   - Phone number

3. **Redeem & Promo Section**
   - REDEEM COINS option (with rewards balance)
   - PROMO CODE option (discount coupons)
   - Radio button selection (mutually exclusive)

4. **Payment Mode Selection**
   - CASH ON DELIVERY (default selected)
   - PAY ONLINE
   - Large teal-colored buttons with radio buttons

5. **Terms & Conditions**
   - Checkbox to accept terms
   - Link to terms & conditions page

### 6. Bookings Management Flow

```
BookingsPage
    ↓ (Tap "VIEW ORDER" button)
BookingDetailsPage
    ↓ (Tap time icon)
SelectDateAndTimePage (for rescheduling)
```

**Files:**
- `lib/ui/bookings/bookings_page.dart` - List of user bookings
- `lib/ui/bookings/booking_details_page.dart` - Individual booking details
- Shows booking status, order ID, service type, date

### 7. Wallet Flow

```
HomeContent / AccountPage
    ↓ (Navigate to wallet)
WalletScreen
    ↓ (View balance, transactions)
PaymentWebViewScreen (if making payment)
```

**Files:**
- `lib/ui/wallet/wallet_screen.dart` - Wallet balance and transactions
- Uses `WalletBloc` for state management
- Fetches balance from API via `WalletRepository`

## Data Models

### Booking Data Structure
The booking confirmation screen expects the following data structure:

```dart
{
  serviceName: String,           // e.g., "Plumbing"
  serviceType: String,           // e.g., "PLUMBER"
  scheduledDate: DateTime?,      // Selected date
  scheduledTime: String?,        // e.g., "10:00 AM - 12:00 PM"
  addressName: String,           // Contact name
  buildingName: String,          // Building/Villa name
  fullAddress: String,           // Complete address
  phoneNumber: String,           // Contact number
  serviceInformation: String,    // Service details
}
```

### User Data Models
- `CustomerModel` - User profile information
- `LoginResponseModel` - Login response with token
- `WalletBalanceResponseModel` - Wallet balance data

## State Management

### BLoC Pattern
The app uses BLoC (Business Logic Component) pattern:

1. **LoginBloc**
   - Handles authentication
   - States: `Authenticated`, `Unauthenticated`, `Loading`, `Error`

2. **WalletBloc**
   - Handles wallet operations
   - Events: `FetchWalletBalance`
   - States: `WalletInitial`, `WalletLoading`, `WalletLoaded`, `WalletError`

3. **ProfileBloc**
   - Handles user profile
   - Events: `FetchProfile`
   - States: `ProfileInitial`, `ProfileLoading`, `ProfileSuccess`, `ProfileFailure`

## Key Files and Their Purposes

### UI Screens
- `lib/ui/splash/splash_screen.dart` - Initial splash/loading screen
- `lib/ui/onbording/onbording_page.dart` - First-time onboarding
- `lib/ui/login/login_page.dart` - Phone number login
- `lib/ui/login/otp_page.dart` - OTP verification
- `lib/ui/home/home_page.dart` - Home content with services
- `lib/ui/home/home_pagefun.dart` - Main home page with bottom nav
- `lib/ui/servicedetails/service_details_screen.dart` - Service details view
- `lib/ui/bookings/service/service_page.dart` - Service booking form
- `lib/ui/bookingconfirm/booking_confrim_screen.dart` - **Booking confirmation** ← NEW
- `lib/ui/bookings/bookings_page.dart` - User's bookings list
- `lib/ui/bookings/booking_details_page.dart` - Individual booking details
- `lib/ui/bookings/select_date_time_page.dart` - Date/time picker
- `lib/ui/bookings/select_address_page.dart` - Address selection/editing
- `lib/ui/wallet/wallet_screen.dart` - Wallet management
- `lib/ui/account/account_page.dart` - User account page

### Data Layer
- `lib/data/models/` - Data models
- `lib/data/repositories/` - API repositories
  - `auth_repository.dart` - Authentication API
  - `wallet_repository.dart` - Wallet API
  - `profile_repository.dart` - Profile API

### Business Logic
- `lib/bloc/` - BLoC implementations
  - `login_bloc.dart` - Authentication logic
  - `wallet_bloc.dart` - Wallet logic
  - `profile_bloc.dart` - Profile logic

### Core Utilities
- `lib/core/storage/storage_service.dart` - Local storage (token, preferences)
- `lib/core/config/api_config.dart` - API configuration
- `lib/core/utils/` - Utility functions

### Constants
- `lib/const/themes/app_themes.dart` - App theme colors
- `lib/const/fixtec_btn.dart` - Reusable button component
- `lib/const/reward_conatiner.dart` - Rewards container widget

## Navigation Patterns

### Push Navigation
- Used for forward navigation (e.g., Home → Service Details)
- `Navigator.push()` - Adds new route to stack

### Push and Replace
- Used for authentication flow
- `Navigator.pushReplacement()` - Replaces current route

### Push and Remove Until
- Used for login/logout
- `Navigator.pushAndRemoveUntil()` - Clears navigation stack

### Pop with Result
- Used for data selection screens
- `Navigator.pop(result)` - Returns data to previous screen

## Recent Implementation: Booking Confirmation Screen

### What Was Implemented
1. **Complete UI matching the design**
   - Dark background (#1A1A1A)
   - White rounded cards for sections
   - Service details display
   - Address display with icon
   - Redeem coins and promo code options
   - Payment mode selection (Cash/Online)
   - Terms & conditions checkbox

2. **Data Integration**
   - Accepts booking data as parameters
   - Displays real booking information
   - Formats date and time properly
   - Shows address details

3. **User Interactions**
   - Radio button selection for redeem/promo
   - Payment mode selection
   - Terms acceptance checkbox
   - Navigation back button

### Integration Points
- **From**: `ServicePage` passes all booking data
- **To**: Can navigate to terms & conditions (TODO)
- **Data Flow**: All booking information flows from ServicePage

## Future Enhancements

1. **Booking Confirmation Screen**
   - Add "Confirm Booking" button at bottom
   - Integrate with booking API
   - Navigate to success screen after confirmation
   - Handle payment processing for "Pay Online"

2. **Address Management**
   - Save address to backend
   - Load saved addresses
   - Multiple address support

3. **Promo Code**
   - Implement promo code validation
   - Apply discounts
   - Show discount amount

4. **Rewards/Coins**
   - Integrate rewards balance API
   - Apply coins to booking
   - Calculate discount

## Notes

- The app uses Google Fonts (Manrope) for typography
- Theme colors are defined in `AppThemes` class
- All API calls use authentication tokens stored in `StorageService`
- The app follows Material Design guidelines
- Navigation uses Flutter's standard `Navigator` API

