import dotenv from 'dotenv'
import nuxtDefaultConfig from './nuxt.config'
import variables from './variables'

dotenv.config()

const envConfig = {
  baseUrl: process.env.STAGING_BASE_URL,
  apiUrl: process.env.AXIOS_STAGING_BASE_URL
}
const envMixed = Object.assign(envConfig, variables)

const buildConfig = {
  env: envMixed,
  axios: {
    debug: false
  }
}
const mixedConfig = Object.assign(nuxtDefaultConfig, buildConfig)
export default mixedConfig
