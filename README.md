# ByteBazaar - E-Commerce Platform

ByteBazaar is a web-based e-commerce application developed using **Java (Spring Boot)**. It allows users to browse and purchase electronic products online while providing administrators with tools to manage the catalog, orders, and users.  

## Features  

### Public Users  
- **Product Catalog Browsing:** View products by category, brand, or search.  
- **Product Details:** See full specifications and descriptions.  
- **Featured Products:** Explore highlighted items on the homepage.  
- **User Registration:** Sign up to access shopping and order history.  

### Registered Users  
- **Shopping Cart:** Add products, adjust quantities, and view total prices.  
- **Order Placement:** Provide delivery addresses, simulate payments, and confirm purchases.  
- **Order Tracking:** Check order status and view order history.  
- **Wishlist:** Save products for later.  
- **Discount Coupons:** Apply promotional codes at checkout.  
- **Live Order Tracking:** Monitor shipping status.  

### Administrators  
- **User Management:** View, track, and block users.  
- **Product Management:** Add, update, or disable products; manage categories and brands.  
- **Order Oversight:** Review and update order statuses.  
- **Coupon Management:** Create and manage discount codes.  
- **Order Tracking Simulation:** Update delivery progress.

## Technologies Used  
- **Backend & Frontend:** Java: Spring Boot and JSP (it's a monolithic application)
- **Database:** MySQL
- **Authentication:** JWT (JSON Web Token)

## Installation and Setup  

1. **Clone the repository:**  
   ```bash
   git clone https://github.com/1Abdess/ProgettoIngSistemiWeb.git

2. **Navigate to the project directory:**
    ```bash
        cd ProgettoIngSistemiWeb
3. **Set up the database:**
    - Import the dump.sql file into MySQL Workbench.
    - Update database credentials in src/main/resources/application.properties.
4. **Build and run the project:**
    ```bash
        ./gradlew bootRun