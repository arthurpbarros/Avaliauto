<script>
export default {
    components: {},
    emits: ["captarNota"],
    data() {
        return {
            valor: 3
        }
    },
    props: {
        parte_carro: {
            type: String,
            default: ""
        }
    },
    methods: {
        trocar_valor(id) {
            this.valor = id;
            this.$emit("captarNota",this.parte_carro,this.valor);
        }
    }
};
</script>
<template>
    <div class="center">
        <font-awesome-icon icon="fa-solid fa-star" @click="trocar_valor(1)" 
            v-bind:class="{ ativada: this.valor >= 1, desativada: this.valor < 1 }" />
        <font-awesome-icon icon="fa-solid fa-star" @click="trocar_valor(2)" 
            v-bind:class="{ ativada: this.valor >= 2, desativada: this.valor < 2 }" />
        <font-awesome-icon icon="fa-solid fa-star" @click="trocar_valor(3)" 
            v-bind:class="{ ativada: this.valor >= 3, desativada: this.valor < 3 }" />
        <font-awesome-icon icon="fa-solid fa-star" @click="trocar_valor(4)" 
            v-bind:class="{ ativada: this.valor >= 4, desativada: this.valor < 4 }" />
        <font-awesome-icon icon="fa-solid fa-star" @click="trocar_valor(5)"
            v-bind:class="{ ativada: this.valor == 5, desativada: this.valor < 5 }" />
        <font-awesome-icon icon="fa-solid fa-x" class="close" @click="trocar_valor(0)" />
        <!-- <p class="nota">
            <span v-bind:class="{excelente: this.valor > 3, otimo: this.valor == 3,pessimo: this.valor < 3}"> {{valor}}/5</span>
        </p> -->
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
</style>