Introduction to the Product Management Project with Spring Security
The Product Management project, implemented as the spring-security-crud-demo application, is a robust, secure, and user-friendly web application designed to demonstrate a full-fledged CRUD (Create, Read, Update, Delete) system for managing products. Built using Spring MVC (not Spring Boot), the application leverages Spring Security for authentication and authorization, MySQL for
persistent data storage, JPA/Hibernate for object-relational mapping, and JSP for the front-end user interface. Deployed as a WAR file on Tomcat 11.x, the project showcases modern web development practices, emphasizing security, scalability, and an enhanced user experience (UI/UX).
This introduction provides a comprehensive overview of the project, its objectives, architecture, and key features, with a specific focus on the critical role of Spring Security in securing the application. It contextualizes the project within the broader landscape of enterprise web applications, highlighting its technical components, recent enhancements (e.g., UI improvements to the login page and resolution of HTTP 500 errors), and the learning outcomes it delivers for developers exploring Spring-based ecosystems.


## **Product Management Application**

The **Product Management Application** is a secure, role-based web platform designed to manage a product catalog. It is tailored for three distinct user roles—**USER**, **MANAGER**, and **ADMIN**—each with specific access privileges:

* **USER**: Can view the product list and individual product details.
* **MANAGER**: Can view, create, and update products.
* **ADMIN**: Has full access, including the ability to delete products.

---

### **Project Objectives**

1. **Secure CRUD Functionality**: Implement a complete, role-based CRUD system ensuring data integrity and secure access to product data.
2. **Spring Security Integration**: Enforce authentication via a custom login page and implement authorization using role-based access control, along with protection from common security threats like **CSRF**.
3. **Improved UI/UX**: Provide a responsive and accessible interface using **JSP**, styled with `styles.css` and enhanced with `scripts.js` for client-side validation.
4. **Error Handling & Debugging**: Address real-world challenges such as HTTP 500 errors (e.g., caused by missing `-parameters` compiler flag) and ensure robust exception handling.
5. **Learning-Oriented Design**: Offer developers a hands-on experience of configuring Spring without Spring Boot, showcasing traditional Spring MVC and security integration in a Tomcat environment.

This project is ideal for developers transitioning from Java EE to modern Spring-based applications.

---

### **Architecture & Technology Stack**

The application follows the **Model-View-Controller (MVC)** design pattern, ensuring a clean separation of concerns.

---

#### **1. Model Layer**

* **Entity**:
  `Product` (`com.example.model.Product`) with fields:

  * `id`: Auto-incremented identifier
  * `name`: Product name
  * `price`: Product price (decimal)
  * `description`: Product description (text)

* **Database**:
  MySQL database (`product_db`) with access credentials `app_user` / `app_password`.

* **ORM**:
  JPA/Hibernate for mapping the entity to the database.
  Repository: `ProductRepository` (`com.example.repository.ProductRepository`)

---

#### **2. View Layer**

* **JSP Pages** (Located in `src/main/webapp/WEB-INF/views/`):

  * `login.jsp`: Custom login page with logo, styled form, and "Forgot Password" link.
  * `list.jsp`: Product list with view/edit/delete actions (visibility based on user role).
  * `view.jsp`: Product detail view.
  * `form.jsp`: Product creation and update form.

* **Front-End Assets**:

  * `styles.css`: Consistent design with responsive layout, forms, and buttons.
  * `scripts.js`: Client-side validation (e.g., login field validation, delete confirmation).

---

#### **3. Controller Layer**

* **ProductController** (`com.example.controller.ProductController`):
  Handles routes such as:

  * `/products`
  * `/products/new`
  * `/products/save`
  * `/products/edit/{id}`
  * `/products/update`
  * `/products/delete/{id}`

* **LoginController**: Implicitly handled by Spring Security for login page rendering.

---

#### **4. Service Layer**

* **ProductService** (`com.example.service.ProductService`):
  Encapsulates business logic with transaction management and delegates data operations to the repository.

---

#### **5. Configuration**

* **MvcConfig** (`com.example.config.MvcConfig`):

  * Configures Spring MVC, JPA, view resolvers, and resource handling.

* **SecurityConfig** (`com.example.config.SecurityConfig`):

  * Sets up in-memory users, role-based authorization, login/logout mechanisms, and CSRF protection.

* **Maven (pom.xml)**:

  * Includes dependencies:

    * Spring MVC 6.1.13
    * Spring Security 6.1.13
    * Hibernate 6.6.1.Final
    * MySQL Connector 8.0.40
    * Servlet API 6.0.0
    * JSTL 3.0.1
  * Uses `maven-compiler-plugin` with the `-parameters` flag to avoid runtime errors.

---

### **Technology Stack**

| Layer          | Technology                                                       |
| -------------- | ---------------------------------------------------------------- |
| **Back-End**   | Java 17, Spring MVC, Spring Security, Spring Data JPA, Hibernate |
| **Database**   | MySQL 8.0.40                                                     |
| **Front-End**  | JSP, JSTL, CSS, JavaScript                                       |
| **Server**     | Apache Tomcat 10.1.x                                             |
| **Build Tool** | Maven 3.x                                                        |
| **Logging**    | SLF4J, Logback 1.5.12                                            |
