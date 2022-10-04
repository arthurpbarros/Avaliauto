<script>
export default {
    components: {},
    props: {
        valor: {
            type: Number,
            default: 3,
            required: true
        },
        parte_carro: {
            type: String,
            default: "",
            required: true
        }
    },
};
</script>
<template>
    <div class="center">
        <p>{{parte_carro}}</p>
        <font-awesome-icon icon="fa-solid fa-star" 
            v-bind:class="{ ativada: this.valor >= 1, desativada: this.valor < 1 }" />
        <font-awesome-icon icon="fa-solid fa-star"
            v-bind:class="{ ativada: this.valor >= 2, desativada: this.valor < 2 }" />
        <font-awesome-icon icon="fa-solid fa-star"
            v-bind:class="{ ativada: this.valor >= 3, desativada: this.valor < 3 }" />
        <font-awesome-icon icon="fa-solid fa-star" 
            v-bind:class="{ ativada: this.valor >= 4, desativada: this.valor < 4 }" />
        <font-awesome-icon icon="fa-solid fa-star"
            v-bind:class="{ ativada: this.valor == 5, desativada: this.valor < 5 }" />
        <p class="nota">
            <span> {{valor}}/5</span>
        </p>
    </div>
</template>
<style scoped>
/* Cor das estrelas */
.ativada {
    color: #ffc803;    
}
.desativada {
    color: gray;
}
.close {
    margin-left: 5px;
    color: rgb(231, 66, 66);
}

/* Estrutura */
.center {
    text-align: center;
    margin-top: 20px;
}
.conteudo{
    color: white;
}
/* Alteração de cores devido a nota */
.nota{
    font-weight: bold;
    font-size: 10pt;
}
.pessimo{
    color: rgb(231, 66, 66);
}
.otimo{
    color: #1540a4;
}
.excelente{
    color: rgb(4, 178, 4);
}
p{
    font-weight: bold;
    color: #1540a4;
}
</style>