<template>
    <div class="container-fluid">
        <router-view />
    </div>
</template>

<script>
export default {
    name: 'App'
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@100;400;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;500;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Fira+Sans:ital,wght@0,400;0,500;0,700;1,400;1,700&display=swap');
a {
    text-decoration: none !important;
}
* {
    font-family: 'Inter', sans-serif;
    margin: 0px;
    padding: 0px;
}

:root {
    --primary: #1540a4;
    --secondary: #f9db6d;
}

.btn:focus {
  outline: none !important;
  box-shadow: none !important;
}

body{
    padding-right: 0px !important;
}
</style>
