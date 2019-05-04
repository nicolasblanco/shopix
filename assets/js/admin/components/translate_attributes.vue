<script>
export default {
  props: ["defaultLocale", "defaultAvailableLocales", "attributesComponentConfig", "t"],
  mounted () {
    this.currentLocale = this.defaultLocale
    this.availableLocales = this.defaultAvailableLocales
    this.attributesComponentConfig.attributes.forEach((attribute) => {
      this.defaultAvailableLocales.forEach(function(locale) {
        attribute.value = attribute.value || {}
        attribute.value[locale] = attribute.value[locale] || null
      })
    })
    this.attributes = this.attributesComponentConfig.attributes
    this.name = this.attributesComponentConfig.name
  },
  methods: {
    htmlInputName (attribute, locale) {
      return this.name + '[' + attribute.name + '_translations][' + locale + ']';
    },
    changeLocale (locale) {
      this.currentLocale = locale
    }
  },
  data () {
    return {
      currentLocale: "en",
      availableLocales: [],
      attributes: [],
      name: null
    }
  }
}
</script>

<template lang="pug">
  .translate-attributes
    .controls
      .input-prepend.input-group
        label(style="margin-right: 1em;")
          i.fa.fa-language(aria-hidden="true")
          | &nbsp;{{ t.translations_in }}
        span(v-for="locale in availableLocales")
          img.langs(:src="`/img/flags/${locale}.png`" v-bind:class="{ active: locale == currentLocale }" @click="changeLocale(locale)" style="width: 60%")

    .form-group(v-for="attribute in attributes" style="margin-top: 1em;")
      label.control-label {{ attribute.display_name }}
      div(v-if="attribute.type == 'string'")
        input.form-control(type="text" v-model="attribute.value[currentLocale]")
      div(v-if="attribute.type == 'text'")
        textarea.form-control(:rows="attribute.rows" v-model="attribute.value[currentLocale]")

    div(v-for="attribute in attributes")
      input(v-for="locale in availableLocales" :name="htmlInputName(attribute, locale)" :value="attribute.value[locale]" type="hidden")

</template>
