<template>
    <div class="list-container">
        <ul class="user-list">
            <li class="user-list__item" v-if="isAdmin()" @click="$router.push({ path: '/admin/analytics'})">
                <v-icon>
                    mdi-account-tie
                </v-icon>
                <div class="user-list__item--text">
                    {{ $t('Admin Area') }}
                </div>
            </li>
            <li class="user-list__item" v-if="!$route.matched.some(record => record.meta.player)" @click="$router.push({ path: $store.getters.getSettings.playerLanding})">
                <v-icon>
                    mdi-music-note-eighth
                </v-icon>
                <div class="user-list__item--text">
                    {{ $t('Player') }}
                </div>
            </li>
            <li class="user-list__item" v-if="isArtist()" @click="$router.push({ path: '/artist/analytics'})">
                <v-icon>
                    mdi-account-music
                </v-icon>
                <div class="user-list__item--text">
                    {{ $t('Artist Area') }}
                </div>
            </li>
            <li class="user-list__item" v-if="isUpgradable" @click="$router.push({ name: 'subscription'})">
                <v-icon>
                    mdi-{{ $store.getters.getSettings.subscriptionButtonIcon }}
                </v-icon>
                <div class="user-list__item--text">
                    {{ $t('Upgrade Account') }}
                </div>
            </li>
            <li class="user-list__item" @click="pushRoute({ name: 'profile', id: $store.getters.getUser.id })">
                <v-icon>
                    mdi-account-circle
                </v-icon>
                <div class="user-list__item--text">
                    {{ $t('Profile') }}
                </div>
            </li>
             <li class="user-list__item"  @click="$router.push({name: 'account-settings'})">
               <v-icon>mdi-account-cog</v-icon><div class="user-list__item--text">
                  {{ $t('Account Settings') }}
                </div> 
            </li>
              <li class="user-list__item"  @click="changeTheme(!$vuetify.theme.dark)">
                <v-icon>mdi-brightness-4</v-icon> <div class="user-list__item--text">
                   {{ $t(($vuetify.theme.dark ? 'Light' : 'Dark') +  ' Mode') }}
                </div>
            </li>
            <li class="user-list__item" @click="$store.dispatch('logout')">
                <v-icon>
                    mdi-logout
                </v-icon>
                <div class="user-list__item--text">
                    {{ $t('Logout') }}
                </div>
            </li>
        </ul>
    </div>
</template>
<style lang="scss" scoped>
.list-container {
    .user-list {
        list-style: none;
        padding: .3em .2em;
        &__item {
            display: flex;
            align-items: center;
            border-radius: 5px;
            padding: .3em .2em;
            &:hover {
                 background-color: rgba(201, 201, 201, 0.308);
            }
            &--text {
                margin-left: .6em;
            }
        }
    }
}
</style>