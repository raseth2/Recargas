import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)
    //estoy usando este de aqui
const state = {
    sidebarShow: 'responsive',
    sidebarMinimize: true,
    url_base2: 'http://192.168.1.209:8000/',
    tipousuario: '',
    name_user:'',
    id_usuario: '',
    url_base: 'https://phpapi.identidadesjuveniles.org/',

}

export default new Vuex.Store({
    state,
    mutations: {
        toggleSidebarDesktop(state) {
            const sidebarOpened = [true, 'responsive'].includes(state.sidebarShow)
            state.sidebarShow = sidebarOpened ? false : 'responsive'
        },
        toggleSidebarMobile(state) {
            const sidebarClosed = [false, 'responsive'].includes(state.sidebarShow)
            state.sidebarShow = sidebarClosed ? true : 'responsive'
        },
        set(state, [variable, value]) {
            state[variable] = value
        },
        settipousuario(state, tipousuario) {
            state.tipousuario = tipousuario
        },
        setIdUsuario(state, id_usuario) {
            state.id_usuario = id_usuario
        },
        set_name_user(state, name_user) {
            state.name_user = name_user
        },
    },
    actions: {
        guardarIdUsuario({ commit }, id_usuario) {
            commit("setIdUsuario", id_usuario)
            localStorage.setItem("id_usuario", id_usuario)
        },
        guardarTipoUsuario({ commit }, tiposusuario) {
            commit("settipousuario", tiposusuario)
            localStorage.setItem("tipousuario", tiposusuario)
        },
        name_user({ commit }, name_user) {
            commit("set_name_user", name_user)
            localStorage.setItem("name_user", name_user)
        },
        last_name({ commit }, last_name) {
            //commit("set_name_user", name_user)
            localStorage.setItem("last_name", last_name)
        },
        player_id({ commit }, player_id) {
            //commit("set_name_user", player_id)
            localStorage.setItem("player_id", player_id)
        },

    }
})

// export default new Vuex.Store({
//     state,
//     mutations
// })