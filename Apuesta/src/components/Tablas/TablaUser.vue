<template>  
  <a-card
    :bordered="false"
    class="header-solid h-full"
    :bodyStyle="{ padding: 0 }"
  >
    <template #title>
      <a-row type="flex" align="middle">
        <a-col :span="24" :md="12">
          <h5 class="font-semibold m-0">{{title}}</h5>       
        </a-col>
      </a-row>
    </template>
    <a-table
      :columns="columns"
      :data-source="data"
      :pagination="true"
      :row-key="(data) => data.id"
    >
      <template slot="state" slot-scope="state">
        <a-tag
          class="tag-status"
          :class="state ? 'ant-tag-primary' : 'ant-tag-muted'"
        >
           <i class="fas fa-check" v-if="state=='1'"></i> 
           <i class="fas fa-exclamation-triangle" v-else></i>
        </a-tag>
    
        <!-- <a-badge count="109" :number-style="{ backgroundColor: '#52c41a' }"   v-if="state=='1'"/>
              <a-badge count="25" v-else /> -->
      </template>
      <template slot="editBtn" slot-scope="data">
        <a-dropdown>
          <template #overlay>
            <a-menu @click="handleMenuClick">
              <a-menu-item key="1" @click="Editar(data)" v-if="data.state=='0'">Editar</a-menu-item>
              <a-menu-item key="2" @click="View(data)">Ver</a-menu-item>
            </a-menu>
          </template>
          <a-button> Acciones </a-button>
        </a-dropdown>
      </template>
    </a-table>
  </a-card>  
</template>

<script>
export default {
  props: {
    data: {
      type: Array,
      default: () => [],
    },
    columns: {
      type: Array,
      default: () => [],
    },
    title:{
      type: String,
      default:""
    }
  }, 
  data() {
    return {      
    };
  },
  methods: {
    Editar(data) {
      this.$emit("Editar", data);     
    },
    View(data) {
      this.$emit("View", data);
    },
    handleMenuClick() {},
  },
};
</script>