<template>
  <div>
    <input v-model="searchTerm" @input="searchOperators" placeholder="Search operators...">
    <ul>
      <li v-for="operator in searchResults" :key="operator.ans_registration">
        {{ operator.legal_name }} - {{ operator.trade_name }}
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return {
      searchTerm: '',
      searchResults: []
    }
  },
  methods: {
    searchOperators() {
      if (this.searchTerm.length > 2) {
        fetch(`http://localhost:5000/search?term=${this.searchTerm}`)
          .then(response => response.json())
          .then(data => {
            this.searchResults = data
          })
      } else {
        this.searchResults = []
      }
    }
  }
}
</script>