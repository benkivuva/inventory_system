# Modern Inventory Management System

A professional, real-time inventory management application built with **Ruby on Rails 8** and **Hotwire**. This system is designed to provide a dynamic, single-page-app experience without the complexity of client-side frameworks, leveraging **Turbo Frames**, **Turbo Streams**, and **Stimulus**.

## Key Features

### Product Management (CRUD)
- **Modern Modal UI**: Create and edit products in polished, accessible modals (no page navigation required).
- **Real-Time Updates**: Changes to product details are instantly reflected in the table via Turbo Streams.
- **Rich Attributes**: Track Name, Description, Price, Quantity, Stock Threshold, and Images.

### Dynamic Stock Tracking
- **Live Stock Adjustments**: Increment/Decrement stock directly from the dashboard.
- **Visual Status Indicators**: 
  - **Ok**: Sufficient stock.
  - **Low**: Stock is at or below the defined threshold.
  - **Out**: Zero quantity.
- **Reactive Counts**: The sidebar product count updates instantly when products are added or removed.

### Advanced Functionality (Bonus)
- **Instant Search**: Filter products as you type (Stimulus-powered).
- **CSV Export**: Download your entire inventory data with one click.
- **Image Support**: Upload and display product thumbnails via Active Storage.
- **Professional Dark Mode**: A custom-designed, high-contrast Slate theme suitable for enterprise use.

---

## Tech Stack

- **Framework**: Ruby on Rails 8.0+
- **Frontend Architecture**: Hotwire (Turbo & Stimulus)
- **Styling**: Tailwind CSS (Dark Mode focused)
- **Database**: SQLite (Development/Test)
- **Testing**: Minitest (Model Unit Tests & Controller Integration Tests)

---

## Setup & Installation

1.  **Clone the repository**
    ```bash
    git clone <repository_url>
    cd inventory_system
    ```

2.  **Install Dependencies**
    ```bash
    bundle install
    ```

3.  **Setup Database**
    ```bash
    bin/rails db:prepare
    # Optionally seed some sample data
    bin/rails db:seed
    ```

4.  **Build Styles**
    ```bash
    bin/rails tailwindcss:build
    ```

5.  **Run the Server**
    ```bash
    bin/dev
    ```
    Visit `http://localhost:3000` in your browser.

---

## Running Tests

A comprehensive test suite covers model validations, business logic, and controller actions.

```bash
bin/rails test
```

Expect **100% pass rate** (12 assertions).

---

## Design Decisions

### 1. Why Modals over Inline Editing?
While inline editing is quick, modals provide a more focused and clean interface for editing complex forms with images and descriptions. We used **Turbo Frames** to load the modal content lazily, ensuring the initial page load is fast.

### 2. Structural Integrity (The tbody Fix)
We avoided wrapping table rows (`tr`) in `turbo-frame` tags, as this is invalid HTML and causes rendering issues. Instead, we use `dom_id` directly on the `tr` and replace the element using **Turbo Streams**. This ensures semantic validity and reliable updates.

### 3. Service Objects
Stock logic is encapsulated in `Inventory::StockManager` (if applicable) or robust Model methods to keep controllers skinny and business logic testable.

### 4. Professional Aesthetics
We moved away from default Tailwind colors to a curated **Slate** palette (`bg-slate-900`, `text-slate-300`) to give the application a premium SaaS look and feel.

---

## Assumptions

- **Single User**: The system is currently designed for a single admin user (no authentication implemented as per initial scope).
- **Currency**: Prices are displayed in USD/Generic currency format.
- **Images**: Assumes local disk storage for development.

---

*Built with Ruby on Rails.*
