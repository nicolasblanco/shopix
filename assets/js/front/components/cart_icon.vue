<script>
  import Vue from 'vue'

  export default {
    data () {
      return {
        count: 5
      }
    },
    created () {
      this.$bus.on('refreshCartTotalQuantity', (quantity) => {
        this.count = quantity
      })
    }
  }
</script>

<template lang="pug">
  i
    span.material-icons.shopping_basket
    span.count {{ count }}
</template>
