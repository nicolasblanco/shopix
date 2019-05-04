<script>
export default {
  props: ["defaultProductProperties", "defaultAvailableLocales", "defaultProperties", "defaultLocale", "t"],
  mounted () {
    this.product_properties = this.defaultProductProperties
    this.properties = this.defaultProperties
    this.currentLocale = this.defaultLocale
    this.availableLocales = this.defaultAvailableLocales
  },
  methods: {
    removeProperty (productProperty) {
      this.product_properties.splice(this.product_properties.indexOf(productProperty), 1)
    },
    addProperty () {
      let newProperty = { property_id: null, value_translations: {} }

      this.availableLocales.forEach(function(locale) {
        newProperty.value_translations[locale] = null
      })
      this.product_properties.push(newProperty)
    },
    changeLocale (locale) {
      this.currentLocale = locale
    }
  },
  data () {
    return {
      product_properties: [],
      properties: [],
      currentLocale: "en",
      availableLocales: []
    }
  }
}
</script>

<template lang="pug">
  .product-properties
    label.control-label(style="margin-bottom: 1em;") {{ t.properties }}
    .controls
      .input-prepend.input-group
        label(style="margin-right: 1em;")
          i.fa.fa-language(aria-hidden="true")
          | &nbsp;{{ t.translations_in }}
        span(v-for="locale in availableLocales")
          img.langs(:src="`/img/flags/${locale}.png`" v-bind:class="{ active: locale == currentLocale }" @click="changeLocale(locale)" style="width: 60%")

    .row(v-for="(product_property, index) in product_properties" style="margin-top: 1em;")
      .form-group.col-sm-3
        select(:name="'product[product_properties][' + index + '][property_id]'" v-model="product_property.property_id" class="form-control")
          option(v-for="property in properties" v-bind:value="property.id")
            | {{ property.key }}
      .form-group.col-sm-7
        .controls
          .input-group
            input(type="text" size="2" v-model="product_property.value_translations[currentLocale]" class="form-control")
            span.input-group-btn
              button(@click.prevent="removeProperty(product_property)" class="btn") -
      input(v-for="locale in availableLocales" type="hidden" :name="'product[product_properties][' + index + '][value_translations][' + locale + ']'" :value="product_property.value_translations[locale]")
    .row
      .form-group.col-sm-4
        button(@click.prevent="addProperty" class="btn") {{ t.add_property }}
</template>
