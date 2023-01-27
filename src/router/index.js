import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/RickandMortyHome.vue'
import CharactersEpisodes from "@/views/CharactersEpisodes.vue";
import LocationView from "@/views/LocationView.vue";

Vue.use(VueRouter)

const routes = [
    {
        path: '/',
        name: 'home',
        component: HomeView
    },
    {
        path: '/episodes',
        name: 'episodes',
        component: CharactersEpisodes
    },
    {
        path: '/location',
        name: 'location',
        component: LocationView
    }
]

const router = new VueRouter({
    mode: 'history',
    base: process.env.BASE_URL,
    routes
})

export default router
