# Be sure to restart your server when you modify this file.

#Martialarts::Application.config.session_store :cookie_store, key: '_martialarts_session'

Martialarts::Application.config.session_store :iron_cache, key: '_martialarts_session' #, namespace: '_martialarts_session'