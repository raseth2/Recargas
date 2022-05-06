<template>
  <div>
    <a-row :gutter="24" type="flex">
      <a-col :span="24" class="mb-24">     
        <br />       
        <TablaUser
          title="Lista de Clientes"
          :data="items"
          :columns="Columns"
           v-on:View="ViewData"
        ></TablaUser>
      </a-col>
    </a-row>

    <a-modal :visible="dialogView" :footer="null" @cancel="handleCancelModal">
      <a-form >      
       <a-row :gutter="[24, 24]">
          <a-col :span="24" :md="12" style="padding: 5px">
           	<a-card :bordered="false" class="widget-2 h-full">
            <a-statistic :value="wallet.total" prefix="S/">
              <template #title>
                <div class="icon" v-html="icon"></div>
                <h6>{{fullName}}</h6>
                <p>{{model.player_id}}</p>
              </template>
            </a-statistic>
          </a-card>
          </a-col>
           <a-col :span="24" :md="12" >
             	<h6 class="font-semibold m-0">Numero de Celular</h6>
               <hr>
            <a-list
              class="invoice-list"
              item-layout="horizontal"
              :split="false"
              :data-source="numberClient"
            >
              <a-list-item slot="renderItem" slot-scope="item">            
                <a-list-item-meta
                  :title="item.number"
                  :description="item.code"
                ></a-list-item-meta>
                <div class="amount">{{ item.state }}</div>
              </a-list-item>
            </a-list>
          </a-col>
      </a-row>
      </a-form>
    </a-modal>

  </div>
</template>

<script>
import axios from "axios";
const Swal = require("sweetalert2");
import { mapState } from "vuex";
import TablaUser from "@/components/Tablas/TablaUser";


import moment from "moment";
import "moment/locale/es";


export default {
  components: {
    TablaUser
  },
  data() {
    return {
      isLoading: false,
      itemUser: [],   
      dialogView:false, 
   
      items: [],
    
   
      wallet:{},
      numberClient:[],
      model: {
        id: 0,
        player_id: null,
        name: null,
        last_name: null,
        number: null,
        amount: 0,
        bank_id: null,
        social_id: null,
        user_id: 1,
        comment: "",
        photo: "",
        date: null,
        email:null,
      },
   
      fecha_actual: moment(new Date()).format("YYYY/MM/DD"),
      Columns: [
        {
          title: "Codigo",
          dataIndex: "id",
        },
        {
          title: "Correo",
          dataIndex: "email",
          scopedSlots: { customRender: "email" },
        },
        {
          title: "Nombre",
          dataIndex: "name",
          scopedSlots: { customRender: "name" },
        },
        {
          title: "Apellido",
          dataIndex: "last_name",
        },
        {
          title: "Player Id",
          dataIndex: "player_id",
        },
        {
          title: "",
          scopedSlots: { customRender: "editBtn" },
          width: 50,
        },
        
      ],
      icon: `
						<svg width="22" height="22" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M9 6C9 7.65685 7.65685 9 6 9C4.34315 9 3 7.65685 3 6C3 4.34315 4.34315 3 6 3C7.65685 3 9 4.34315 9 6Z" fill="#111827"/>
							<path d="M17 6C17 7.65685 15.6569 9 14 9C12.3431 9 11 7.65685 11 6C11 4.34315 12.3431 3 14 3C15.6569 3 17 4.34315 17 6Z" fill="#111827"/>
							<path d="M12.9291 17C12.9758 16.6734 13 16.3395 13 16C13 14.3648 12.4393 12.8606 11.4998 11.6691C12.2352 11.2435 13.0892 11 14 11C16.7614 11 19 13.2386 19 16V17H12.9291Z" fill="#111827"/>
							<path d="M6 11C8.76142 11 11 13.2386 11 16V17H1V16C1 13.2386 3.23858 11 6 11Z" fill="#111827"/>
						</svg>`,
    };
  },
  mounted() {  
    this.ListClients();
  },
  computed: {
    ...mapState(["url_base", "url_base2"]),
    fullName: function () {
      return this.model.name + " " + this.model.last_name;
    },
  },
  methods: {
     ViewData(data) {
      this.model = { ...data };
      this.SearchData(data.id);    
      this.dialogView = true;
    },
    ListClients() {
      let me = this;
      let url = me.url_base2 + "clients/records";
      axios({
        method: "GET",
        url: url,
      })
        .then(function (response) {
          me.items = response.data.result;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    SearchData(cliente_id) {
      let me = this;
      let url = me.url_base2 + "client/info/" + cliente_id;
      axios({
        method: "GET",
        url: url,
      })
        .then(function (response) {        
          me.wallet = response.data.wallet;
          me.numberClient = response.data.numberClient;
        })
        .catch((error) => {
          console.log(error);
        });
    },         
    Clear() {
      this.model.player_id = null;
      this.model.last_name = null;
      this.model.number = null;
      this.model.amount = 0;
      this.model.photo = "";
      this.model.id = 0;
    },
    
    handleHide() {
      this.visible = false;
    },
    handleCancelModal() {
      this.dialogView = false;     
      this.Clear();
    },
   
  },
};
</script>

<style lang="scss"></style>
