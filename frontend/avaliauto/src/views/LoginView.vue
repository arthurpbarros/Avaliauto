<script>
import MenuComponent from '@/components/menu.vue';
export default {
    components: { MenuComponent, },
};
</script>
<template>
    <!-- <div class="container-fluid"> -->
        <MenuComponent :mostrarMenu="true" />
        <div class="row corpo">
            <div class="col-md-6 col-12">
                <h1 id="h1-tipo-1-topo"> Encontre um mecânico para sua avaliação</h1>
                <router-link to="cadastro"> <button class="botao-cadastre-se"> Faça sua consultoria agora</button>
                </router-link>
            </div>
            <div class="col-md-6 col-12">
                <div class="text-center">
                    <img src="../assets/mecanico.png" class="img-fluid" id="mecanico">
                </div>
            </div>
        </div>
        <div class="row textos">
            <div class="col-md-6 col-12">
                <div class="text-center h-100 organizar-items">
                    <img src="../assets/inspecao.png" id="inspect" class="img-fluid">
                </div>
            </div>
            <div class="col-md-6 col-12">
                <h1 id="h1-tipo-2"> Fique seguro ao comprar seu veículo seminovo. </h1>
                <p class="mx-auto texto-azul p-left"> Com o auxílio do Avaliauto, o risco de ser enganado durante a
                    compra é
                    reduzido.
                </p>
            </div>
        </div>
        <div class="row corpo">
            <div class="col-md-6 col-12">
                <h1 id="h1-tipo-1"> Consultoria personalizada em qualquer lugar. </h1>
                <p class="mx-auto p-right"> Nossos mecânicos irão até o local da venda para ver e avaliar seu possível
                    novo
                    carro de perto.</p>
            </div>
            <div class="col-md-6 col-12">
                <div class="text-center h-100 organizar-items">
                    <img src="../assets/navegacao.png" id="localizacao" class="img-fluid">
                </div>
            </div>
        </div>
        <div class="row rodape">
            <div class="col-6 col-sm-6">
                <div id="flags">
                    <a href="https://google.com" target="_blank">
                        <font-awesome-icon icon="fa-brands fa-github" class="icone" />
                    </a> <span class="separador"> </span>
                    <a href="https://google.com" target="_blank">
                        <font-awesome-icon icon="fa-solid fa-envelope" class="icone" />
                    </a> <span class="separador"> </span>
                    <a href="https://google.com" target="_blank">
                        <font-awesome-icon icon="fa-brands fa-instagram" class="icone" />
                    </a>

                </div>
            </div>
            <!-- <div class="col-6 col-sm-6">
                <ul id="equipe">
                    <li>Arthur</li>
                    <li>Carol</li>
                    <li>Arnold</li>
                    <li>Guilherme</li>
                    <li>Artônio</li>
                </ul>
            </div> -->
        </div>
    <!-- </div> -->
</template>
<style>
body {
    background-color: #1540a4 !important;
    /* background-image: url("../assets/carwallpaper.jpg") !important;
    background-position: center;
    background-size: cover;
    background-attachment: fixed; */
}
</style>
<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap');
no-padding {
    padding-left: 0;
    padding-right: 0;
}

.bg-fundo-azul {
    background-color: #1540a4;
}

#logo-menu {
    width: 180px;
    margin-top: 8px;
    margin-left: 5%;
    float: left;
}

#logo {
    width: 180px;
    margin-bottom: 20px;
}

h5 {
    font-family: 'Inter', sans-serif;
}

.organizar-items {
    display: flex;
    justify-content: center;
    align-items: center;
}

#mecanico {
    margin-top: 5%;
    margin-bottom: 0%;
    width: 80%;
}

.textos {
    background-color: #f9db6d;
}

.texto-azul {
    color: #1540a4 !important;
}

#h1-tipo-1-topo {
    /* background-color: #1540a4; */
    font-weight: bold;
    color: #f9db6d;
    text-align: left;
    margin-top: 20%;
    float: right;
}

.p-right {
    font-size: 16pt;
    color: #f9db6d;
    text-align: left;
    font-weight: normal;
    margin-bottom: 20%;
    width: 95%;
    float: right;
}

.p-left {
    font-size: 16pt;
    color: #1540a4;
    text-align: left;
    font-weight: normal;
    margin-bottom: 20%;
    width: 95%;
    float: left;
}

#h1-tipo-1 {
    /* background-color: #1540a4; */
    font-weight: bold;
    color: #f9db6d;
    text-align: left;
    margin-top: 20%;
    margin-bottom: 5%;
    float: right;
}

#h1-tipo-2 {
    font-weight: bold;
    color: #1540a4;
    text-align: left;
    margin-top: 20%;
    margin-bottom: 5%;
    float: left;
    /* background-color: #FBBC5C; */
}

#h1-tipo-1,
#h1-tipo-2,
#h1-tipo-1-topo {
    font-size: 35pt;
    width: 95%;
}

#menu {
    background-color: #1540a4;
    min-height: 50px;
    width: 100%;
    color: #1540a4;
    text-align: center;
    font-size: 1em;
}

.botao-login {
    border: 0.05px solid #f9db6d;
    height: 40px;
    padding-left: 10px;
    padding-right: 10px;
    margin-top: 5px;
    float: right;
    margin-right: 10px;
}

.botao-cadastre-se {
    border: 0.05px solid #f9db6d;
    height: 40px;
    padding-left: 10px;
    padding-right: 10px;
    margin-top: 10px;
    margin-left: 5%;
    background-color: #f9db6d;
    border-radius: 5px;
    font-weight: bold;
    color: #1540a4;
}

.botao-cadastre-se:hover {
    color: #f9db6d;
    background-color: #1540a4;
    border-radius: 5px;
}

.item-menu {
    transition: all 0.4s;
    background-color: #f9db6d;
    border-radius: 5px;
    font-weight: bold;
    color: #1540a4;
}

.item-menu:hover {
    /* border-bottom: 1px solid #1540a4; */
    color: #f9db6d;
    background-color: #1540a4;
    border-radius: 5px;
}

.item-menu-no-important {
    transition: all 0.4s;
    border-radius: 5px;
    line-height: 50px;
    padding: 8px;
    font-weight: bold;
    color: #f9db6d;
}

.corpo {
    background-color: #1540a4;
}

.rodape {
    height: 200px;
    background-color: #050e25;
}

.icone {
    color: white;
    width: 30px;
    height: 30px;
    margin-top: 80px;
}

.icone:hover, #equipe li:hover {
    color: var(--secondary);
}

#flags {
    display: flex;
    flex-direction: row;
    justify-content: center;
    height: 100%;
    /* float: left; */
}

#equipe{
    text-align: center;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    list-style: none;
    color: white;
}
/* #equipe li{
    font-family: 'Source Sans Pro', sans-serif;
} */

.separador{
    height: 20%;
    width: 1px;
    background-color: white;
    margin-right: 20px;
    margin-left: 20px;
    margin-top: 75px;
}

@media (min-width: 1041px) and (max-width: 1147px) {
    #h1-tipo-1-topo {
        margin-top: 10%;
    }
}

@media (min-width: 768px) and (max-width: 1040px) {
    #h1-tipo-1-topo {
        margin-top: 11%;
    }

    #h1-tipo-2 {
        margin-top: 10%;
        margin-bottom: 0%;
        /* background-color: #FBBC5C; */
    }

    #h1-tipo-1 {
        /* background-color: #1540a4; */
        margin-top: 10%;
        margin-bottom: 0%;
    }

    #h1-tipo-1,
    #h1-tipo-2,
    #h1-tipo-1-topo {
        font-size: 28pt;
        width: 95%;
    }

    p {
        margin-top: 5%;
        margin-bottom: 5%;
    }
}

@media (max-width: 767px) {

    #h1-tipo-1-topo,
    #h1-tipo-1,
    #h1-tipo-2 {
        margin-top: 10%;
    }

    .p-left {
        margin-top: 0%;
        margin-bottom: 10%;
        float: right;
    }

    #h1-tipo-2 {
        float: right;
    }
}
</style>
