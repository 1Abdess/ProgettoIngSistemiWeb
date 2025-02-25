<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registrazione</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-blue-50">

<!-- Navbar con solo il nome dell'azienda centrato -->
<nav class="bg-blue-800 p-4 shadow-lg">
  <div class="container mx-auto flex justify-center items-center">
    <a href="/" class="text-white text-4xl font-extrabold tracking-wider">
      ByteBazaar
    </a>
  </div>
</nav>

<!-- Form di registrazione -->
<div class="container mx-auto mt-12 p-6 bg-white shadow-lg rounded-lg max-w-lg">
  <h2 class="text-3xl font-bold text-center text-blue-700 mb-6">Registrati</h2>

  <form action="/registrazione" method="post" class="space-y-4">
    <!-- Email input -->
    <div>
      <label for="email" class="block text-lg font-medium text-gray-700">Email:</label>
      <input type="email" id="email" name="email" required
             class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">
    </div>

    <!-- Nome Utente input -->
    <div>
      <label for="nomeUtente" class="block text-lg font-medium text-gray-700">Nome Utente:</label>
      <input type="text" id="nomeUtente" name="nomeUtente" required
             class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">
    </div>

    <!-- Password input -->
    <div>
      <label for="password" class="block text-lg font-medium text-gray-700">Password:</label>
      <input type="password" id="password" name="password" required
             class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">
    </div>

    <!-- Submit button -->
    <div class="text-center">
      <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded-md hover:bg-blue-700 transition duration-300">
        Registrati
      </button>
    </div>
  </form>

  <!-- Login link -->
  <p class="text-center mt-4">Hai già un account?
    <a href="/login" class="text-blue-600 hover:underline">Login</a>
  </p>
</div>

</body>
</html>
