<template>
  <div>
    <a-row :gutter="24" type="flex">
      <a-col :span="24" class="mb-24">
        <a-button type="primary" @click="AddRecarga()">
          NUEVA RECARGA
        </a-button>     
        <br />
        <br />
        <br />
        <TablaUser
         title="Lista de Recargas"
          :data="items"
          :columns="Columns"
         
          v-on:Editar="Editar"
          v-on:View="ViewData"
        ></TablaUser>
      </a-col>
    </a-row>

    <a-modal
      :visible="dialogRecarga"
      :footer="null"
      @cancel="handleCancelModal"
    >
      <a-form @submit.prevent="Validate">
        <b-form-group label="Player Id :">
          <v-select
            placeholder="Buscar un cliente"
            class="w-100"
            :filterable="false"
            label="name"
            v-model="client"
            :options="clients"
            @search="SearchCliente"
          ></v-select>
          <small v-if="errors.id_provider" class="form-text text-danger"
            >Seleccione un Cliente</small
          >
        </b-form-group>

        <a-row :gutter="[24, 24]">
          <a-col :span="24" :md="12" style="padding: 5px">
            <a-form-item label="Numero Celular">
              <a-input v-model="model.number"> </a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12" :md="12" style="padding: 5px">
            <a-form-item label="Monto">
              <a-input v-model="model.amount"> </a-input>
            </a-form-item>
          </a-col>

          <a-col :span="12" :md="12" style="padding: 5px">
            <a-form-item label="Tipo de Comunicacion">
              <a-select style="width: 100%" v-model="model.social_id">
                <a-select-option
                  v-for="item in networkSocial"
                  :key="item.value"
                >
                  {{ item.text }}
                </a-select-option>
              </a-select>
            </a-form-item>
          </a-col>

          <a-col :span="12" :md="12" style="padding: 5px">
            <a-form-item label="Tipo de Banco">
              <a-select style="width: 100%" v-model="model.bank_id">
                <a-select-option v-for="item in Banks" :key="item.value">
                  {{ item.text }}
                </a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
          <a-col :span="12" :md="12" style="padding: 5px">
            <a-upload
              list-type="picture-card"
              :file-list="fileList"
              :remove="handleRemove"
              @change="handleChange"
              :before-upload="beforeUpload"
              @preview="handlePreview"
            >
              <div v-if="fileList.length < 1">
                <a-icon type="plus" />
                <div class="ant-upload-text">Clic</div>
              </div>
            </a-upload>
          </a-col>
        </a-row>
        <a-form-item>
          <a-button type="primary" html-type="submit"> REGISTRAR </a-button>
        </a-form-item>
      </a-form>
    </a-modal>

    <a-modal :visible="dialogEdit" :footer="null" @cancel="handleCancelModal">
      <a-form @submit.prevent="Validate2">       
        <b-form-group label="Cliente :">
          <a-input v-model="fullName"> </a-input>
        </b-form-group>

        <a-row :gutter="[24, 24]">
          <a-col :span="24" :md="12" style="padding: 5px">
            <a-form-item label="Numero Celular">
              <a-input v-model="model.number"> </a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12" :md="12" style="padding: 5px">
            <a-form-item label="Monto">
              <a-input v-model="model.amount"> </a-input>
            </a-form-item>
          </a-col>

          <a-col :span="12" :md="12" style="padding: 5px">
            <a-form-item label="Tipo de Comunicacion">
              <a-select style="width: 100%" v-model="model.social_id">
                <a-select-option
                  v-for="item in networkSocial"
                  :key="item.value"
                >
                  {{ item.text }}
                </a-select-option>
              </a-select>
            </a-form-item>
          </a-col>

          <a-col :span="12" :md="12" style="padding: 5px">
            <a-form-item label="Tipo de Banco">
              <a-select style="width: 100%" v-model="model.bank_id">
                <a-select-option v-for="item in Banks" :key="item.value">
                  {{ item.text }}
                </a-select-option>
              </a-select>
            </a-form-item>
          </a-col>

          <a-col :span="24" :md="23" style="padding: 5px">
            <a-form-item label="Mensaje">
              <a-input v-model="model.comment"> </a-input>
            </a-form-item>
          </a-col>
        </a-row>
        <a-upload
              list-type="picture-card"
              :file-list="fileList"
              :remove="handleRemove"
              @change="handleChange"
              :before-upload="beforeUpload"
              @preview="handlePreview"
            >
              <div v-if="fileList.length < 1">
                <a-icon type="plus" />
                <div class="ant-upload-text">Clic</div>
              </div>
            </a-upload>
        <a-form-item>
          <a-button type="primary" html-type="submit"> EDITAR </a-button>
        </a-form-item>
      </a-form>
    </a-modal>

 <a-modal :visible="dialogView" :footer="null" @cancel="handleCancelModal">
      <a-form >       
        <b-form-group label="Cliente :">
          <a-input v-model="fullName"> </a-input>
        </b-form-group>

        <a-row :gutter="[24, 24]">
          <a-col :span="24" :md="12" style="padding: 5px">
            <a-form-item label="Numero Celular">
              <a-input v-model="model.number"> </a-input>
            </a-form-item>
          </a-col>
          <a-col :span="12" :md="12" style="padding: 5px">
            <a-form-item label="Monto">
              <a-input v-model="model.amount"> </a-input>
            </a-form-item>
          </a-col>

          <a-col :span="12" :md="12" style="padding: 5px">
            <a-form-item label="Tipo de Comunicacion">
              <a-select style="width: 100%" v-model="model.social_id">
                <a-select-option
                  v-for="item in networkSocial"
                  :key="item.value"
                >
                  {{ item.text }}
                </a-select-option>
              </a-select>
            </a-form-item>
          </a-col>

          <a-col :span="12" :md="12" style="padding: 5px">
            <a-form-item label="Tipo de Banco">
              <a-select style="width: 100%" v-model="model.bank_id">
                <a-select-option v-for="item in Banks" :key="item.value">
                  {{ item.text }}
                </a-select-option>
              </a-select>
            </a-form-item>
          </a-col>

          <a-col :span="24" :md="23" style="padding: 5px">
            <a-form-item label="Mensaje">
              <a-input v-model="model.comment"> </a-input>
            </a-form-item>
          </a-col>
        </a-row>
        <a-upload
              list-type="picture-card"
              :file-list="fileList"           
              :before-upload="beforeUpload"
              @preview="handlePreview"
            >
              <div v-if="fileList.length < 1">
                <a-icon type="plus" />
                <div class="ant-upload-text">Clic</div>
              </div>
            </a-upload>     
      </a-form>
    </a-modal>

    <a-modal :visible="previewVisible" :footer="null" @cancel="handleCancel">
      <img alt="example" style="width: 100%" :src="previewImage" />
    </a-modal>

     <a-modal :visible="previewVisible2" :footer="null" @cancel="handleCancel">
      <img alt="example" style="width: 100%" :src="previewImage2" />
    </a-modal>
    <!--     
 <LoadingComponent :is-visible="isLoading"/> -->
  </div>
</template>

<script>
import axios from "axios";
const Swal = require("sweetalert2");
import { mapState } from "vuex";
import TablaUser from "@/components/Tablas/TablaUser";
import VueEasyLightbox from "vue-easy-lightbox";

import vSelect from "vue-select";
import "vue-select/dist/vue-select.css";
import "vue-select/src/scss/vue-select.scss";

import moment from "moment";
import "moment/locale/es";

//import LoadingComponent from './../Loanding/Loanding'

function getBase64(file) {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => resolve(reader.result);
    reader.onerror = (error) => reject(error);
  });
}

export default {
  components: {
    TablaUser,
    vSelect,
    VueEasyLightbox,
  },
  data() {
    return {
      isLoading: false,
      itemUser: [],
      dialogRecarga: false,
      dialogEdit: false,
      dialogView:false,
      visible: false,
      validate: false,
      previewVisible: false,
      previewVisible2:false,
      previewImage: "",
      previewImage2:'',
      fileList: [],
      items: [],
      bank: null,
      networkSocial: [],
      Banks: [],
      errors: { id_provider: null },
      clients: [],
      client: { id: 0, name: "", player_id: null },
      model: {
        id: 0,
        cliente_id: 0,
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
      },
      errors: {
        cliente_id: false,
        player_id: false,
        number: false,
        amount: false,
        bank_id: false,
        social_id: false,
        photo: false,
      },
      tipe:true,
      fecha_actual: moment(new Date()).format("YYYY/MM/DD"),
      Columns: [
        {
          title: "Codigo",
          dataIndex: "id",
        },
        {
          title: "Cliente",
          dataIndex: "name",
          scopedSlots: { customRender: "nombre" },
        },
        {
          title: "APELLIDO",
          dataIndex: "last_name",
          scopedSlots: { customRender: "apellido" },
        },
        {
          title: "RECARGA",
          dataIndex: "amount",
        },
        {
          title: "ESTADO",
          dataIndex: "state",
          scopedSlots: { customRender: 'state' },
        },
        {
          title: "",
          scopedSlots: { customRender: "editBtn" },
          width: 50,
        },
      ],
    };
  },
  mounted() {
    this.Tables();
    this.ListAll();
  },
  watch: {
    client: function (val, oldVal) {
      if (val.id != null) {
        this.model.cliente_id = val.id;
        this.model.player_id = val.player_id;
        this.SearchNumber(val.id);
      }
    },
  },
  computed: {
    ...mapState(["url_base", "url_base2"]),
    fullName: function () {
      return this.model.name + " " + this.model.last_name;
    },
  },
  methods: {
    Validate,
    SearchCliente,    
    AddRecarga() {
      this.clients=[];
      this.client=null;
      this.tipe=true;
      this.fileList=[];
      this.dialogRecarga = true;
    },
    ListAll() {
      let me = this;
      let url = me.url_base2 + "recharge";
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
    SearchNumber(cliente_id) {
      let me = this;
      let url = me.url_base2 + "number/default/" + cliente_id;
      axios({
        method: "GET",
        url: url,
      })
        .then(function (response) {
          // console.log(response);
          me.model.number = response.data.result.number;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    Tables() {
      let me = this;
      let url = me.url_base2 + "recharge/tables";
      axios({
        method: "GET",
        url: url,
      })
        .then(function (response) {
          let network = response.data.socialNetwork;
          let banks = response.data.banks;
          network.map(function (x) {
            me.networkSocial.push({
              text: x.name,
              value: x.id,
              id: x.id,
            });
          });
          banks.map(function (x) {
            me.Banks.push({
              text: x.description,
              id: x.id,
              value: x.id.toString(),
            });
          });
        })
        .catch((error) => {
          console.log(error);
        });
    },
    Save() {
      const data = new FormData();
      let me = this;
      me.isLoading = true;
      let url = me.url_base2 + "recharge";
      data.append("cliente_id", me.model.cliente_id);
      data.append("player_id", me.model.player_id);
      data.append("number", me.model.number);
      data.append("amount", me.model.amount);
      data.append("bank_id", me.model.bank_id);
      data.append("social_id", me.model.social_id);
      data.append("user_id", me.model.user_id);
      data.append("comment", me.model.comment);
      data.append("photo", me.model.photo);
      data.append("date", moment(new Date()).format("YYYY/MM/DD"));
      axios({
        method: "POST",
        url: url,
        data: data,
        headers: { "Content-Type": "multipart/form-data" },
      })
        .then(function (response) {
         // console.log(response)
          me.isLoading = false;
          if (response.data.status == "200") {
            me.MensajeOk("Registrado con Exito !");
            //    me.ListPhtoOrga();
            me.dialogRecarga = false;
            me.handleRemove(me.model.photo);
            me.ListAll();
            me.Clear();
          } else if ((response.data.status = "404")) {
            Swal.fire({
              icon: "warning",
              text: response.data.message,
              timer: 3000,
            });
          }
        })
        .catch((error) => {
          me.isLoading = false;
          console.log(error);
        });
    },
    Validate2() {
      let me = this;
      let url = me.url_base2 + "recharge";
      let data = me.model;
      axios({
        method: "PUT",
        url: url,
        data: data,
      })
        .then(function (response) {
          console.log(response);
          if (response.data.status == "200") {
            me.MensajeOk("Registrado con Exito !");
            me.ListAll();
            me.Clear();
            me.dialogEdit = false;
            me.tipe=true;
          } else if ((response.data.status = "404")) {
            Swal.fire({
              icon: "warning",
              text: response.data.response,
              timer: 3000,
            });
          }
        })
        .catch((error) => {
          console.log(error);
        });
    },
    Editar(data) {
      this.model = { ...data };
      this.fileList=[];
      this.previewImage2="";
      this.tipe=false;
      let modelo= {...this.items.find(x=>x.id==data.id)}      
      this.fileList.push({
          uid: '-1',
          name: 'image.png',
          status: 'done',
          url: this.url_base2 +modelo.photo,
        }) 
        this.previewImage=this.url_base2 +modelo.photo;
        this.dialogEdit = true;
    },
    ViewData(data) {
      this.model = { ...data };
      this.fileList=[];
      this.previewImage2="";
      this.tipe=false;
      let modelo= {...this.items.find(x=>x.id==data.id)}      
       this.fileList.push({
          uid: '-1',
          name: 'image.png',
          status: 'done',
          url: this.url_base2 +modelo.photo,
        }) 
        this.previewImage=this.url_base2 +modelo.photo;     
        this.dialogView = true;
    },
    Clear() {
      this.model.player_id = null;
      this.model.last_name = null;
      this.model.number = null;
      this.model.amount = 0;
      this.model.photo = "";
      this.model.id = 0;
    },
    beforeUpload(file) {
      this.fileList = [...this.fileList, file];
      return false;
    },
    handleHide() {
      this.visible = false;
    },
    handleRemove(file) {
      const index = this.fileList.indexOf(file);
      const newFileList = this.fileList.slice();
      newFileList.splice(index, 1);
      this.fileList = newFileList;
    },
    async handlePreview(file) {
      if (this.tipe) {
        if (!file.url && !file.preview) {
        file.preview = await getBase64(file.originFileObj);
      }
        this.previewImage = this.fileList[0].thumbUrl;
        this.previewVisible = true;
        }else{
         this.previewVisible = true;
      }
      
    },
    handleCancel() {
      this.previewVisible = false;
    },
    handleChange(e) {
      let me = this;
      me.model.photo = e.file;
      me.fileList = e.fileList;
      if (me.fileList.length > 0) {
        var img = new Image();
        var URL = window.URL || window.webkitURL;
        img.src = URL.createObjectURL(e.file);
        img.onload = function () {
          var ancho = img.width;
          var alto = img.height;
        };
      }
    },
    MensajeOk(mensaje) {
      Swal.fire({
        title: "Exito!",
        text: mensaje,
        icon: "success",
        showCancelButton: false,
        confirmButtonColor: "#3085d6",
        confirmButtonText: "Ok",
      }).then((result) => {
        if (result.isConfirmed) {
          //  this.ClearText();
          this.validateEquipo = false;
        }
      });
    },
    handleCancelModal() {
      this.dialogRecarga = false;
      this.dialogEdit = false;
      this.dialogView=false;
      this.Clear();
    },
    Delete(id, nombre) {
      let me = this;
      Swal.fire({
        title: "Desea Eliminar?",
        text: "Va a Eliminar a " + nombre,
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Si, Eliminar!",
      }).then((result) => {
        if (result.isConfirmed) {
          //  me.Eliminar(id);
        }
      });
    },
  },
};

function SearchCliente(search, loading) {
  let me = this;
  let url = me.url_base2 + "search-clients/" + search;
  if (search !== "") {
    loading(true);
    axios({
      method: "GET",
      url: url,
    }).then(function (response) {
      me.clients = response.data.result;
      loading(false);
    });
  }
}

function Validate() {
  this.errors.cliente_id = this.model.cliente_id == 0 ? true : false;
  this.errors.player_id = this.model.player_id == null ? true : false;
  this.errors.number = this.model.number == null ? true : false;
  this.errors.amount = this.model.amount == 0 ? true : false;
  this.errors.bank_id = this.model.bank_id == null ? true : false;
  this.errors.social_id = this.model.social_id == null ? true : false;
  this.errors.photo = this.model.photo == "" ? true : false;

  if (this.errors.cliente_id) {
    this.validate = true;
    Swal.fire({
      icon: "warning",
      text: "Verifique que campos necesarios esten llenados",
      timer: 2000,
    });
    return false;
  } else {
    this.validate = false;
  }
  if (this.errors.player_id) {
    this.validate = true;
    Swal.fire({
      icon: "warning",
      text: "Verifique que campos necesarios esten llenados",
      timer: 2000,
    });
    return false;
  } else {
    this.validate = false;
  }
  if (this.errors.number) {
    this.validate = true;
    Swal.fire({
      icon: "warning",
      text: "Verifique que campos necesarios esten llenados",
      timer: 2000,
    });
    return false;
  } else {
    this.validate = false;
  }
  if (this.errors.amount) {
    this.validate = true;
    Swal.fire({
      icon: "warning",
      text: "Verifique que campos necesarios esten llenados",
      timer: 2000,
    });
    return false;
  } else {
    this.validate = false;
  }
  if (this.errors.bank_id) {
    this.validate = true;
    Swal.fire({
      icon: "warning",
      text: "Verifique que campos necesarios esten llenados",
      timer: 2000,
    });
    return false;
  } else {
    this.validate = false;
  }

  if (this.errors.social_id) {
    this.validate = true;
    Swal.fire({
      icon: "warning",
      text: "Verifique que campos necesarios esten llenados",
      timer: 2000,
    });
    return false;
  } else {
    this.validate = false;
  }

  if (this.errors.photo) {
    this.validate = true;
    Swal.fire({
      icon: "warning",
      text: "Verifique que campos necesarios esten llenados",
      timer: 2000,
    });
    return false;
  } else {
    this.validate = false;
  }

  ///let me = this;

  if (!this.validate) {
    Swal.fire({
      title: "Desea Registrar?",
      text: "",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Si, Estoy de acuerdo!",
    }).then((result) => {
      if (result.value) {
         this.Save();
      }
    });
  }
}
</script>

<style lang="scss"></style>
