<template>
  <div class="sign-in">
    <a-row type="flex" :gutter="[24, 24]" justify="space-around" align="middle">
      <a-col
        :span="24"
        :md="12"
        :lg="{ span: 12, offset: 0 }"
        :xl="{ span: 6, offset: 2 }"
        class="col-form"
      >
        <br /><br /><br /><br />
        <h1 class="mb-15">Bienvenido</h1>
        <h5 class="font-regular text-muted">Ingresar Correo y constraseña</h5>

        <a-form
          id="components-form-demo-normal-login"
          :form="form"
          class="login-form"
          @submit.prevent="Login"
        >
          <a-select
            ref="select"
            v-model="value1"
            style="width: 100%"
            @focus="focus"
            @change="handleChange"
          >
            <a-select-option value="Empresa">Empresa</a-select-option>
            <a-select-option value="Cliente">Cliente</a-select-option>
         
          </a-select>
          <a-form-item class="mb-10" label="Correo" :colon="false">
            <a-input v-model="email" placeholder="Email" />
          </a-form-item>
          <a-form-item class="mb-5" label="Contraseña" :colon="false">
            <a-input
              type="password"
              v-model="password"
              placeholder="Password"
            />
          </a-form-item>
          
          <a-form-item>
            <a-button
              type="primary"
              block
              html-type="submit"
              class="login-form-button"
            >
              INGRESAR
            </a-button>
          </a-form-item>
        </a-form>
      </a-col>

      <a-col :span="24" :md="10" :lg="10" :xl="10">
        <img src="images/apuesta.jpg" width="510" height="430" alt="" />
      </a-col> 
    </a-row>
  </div>
</template>

<script>
import axios from "axios";
const Swal = require("sweetalert2");
import { mapState } from 'vuex'

export default {
  data() {
    return {
      // Binded model property for "Sign In Form" switch button for "Remember Me" .
      rememberMe: true,
	    email: 'promotor@gmail.com',
      password: '123456',
      value1:null
    
    };
  },
  beforeCreate() {
 
    this.form = this.$form.createForm(this, { name: "normal_login" });
  },
  computed: {
    ...mapState(['url_base','url_base2'])   
  },
  methods: {
    focus () {
      console.log('focus');
    },
    handleChange (value) {
      console.log(`selected ${value}`);
    },
    Login() {
       if (this.email.length == 0) {
        this.errors.email = true;
      }
      if (this.password.length == 0) {
        this.errors.password = true;
      }
       if (this.value1 == null) {
         alert("elija el tipo de usuario");
         return;
      }
      if (this.value1=="Empresa") { 
          let me = this;
          // const email = this.email;
          // const password = this.password;	 
          let url = me.url_base2+ "loginuser";
          let data = {
            email: me.email,
            password: me.password,       
          };
          axios({
            method: "POST",
            url: url,    
            data: data,
          }).then(function(response) {
          
            if (response.data.status == 200) {            
                me.$store.dispatch("guardarTipoUsuario",response.data.type_user.name);  
                me.$store.dispatch("guardarIdUsuario",response.data.result.user.id);    
                me.$store.dispatch("name_user",response.data.result.user.name);    
                me.$session.start()   
                me.$router.push("/");        
            } else {
              Swal.fire({
                icon: "error",
                title: "Datos incorrectos",
                showConfirmButton: false,
                timer: 1500,
              });
            }
          });
      } else{
          let me = this;      
          let url = me.url_base2+ "loginclient";
          let data = {
            email: me.email,
            password: me.password,       
          };
          axios({
            method: "POST",
            url: url,    
            data: data,
          }).then(function(response) {
          
            if (response.data.status == 200) {            
                me.$store.dispatch("guardarTipoUsuario","Cliente");  
                me.$store.dispatch("guardarIdUsuario",response.data.result.user.id);    
                me.$store.dispatch("name_user",response.data.result.user.name);    
                me.$store.dispatch("last_name",response.data.result.user.last_name); 
                me.$store.dispatch("player_id",response.data.result.user.player_id);  
                me.$session.start()   
                me.$router.push("/");        
            } else {
              Swal.fire({
                icon: "error",
                title: "Datos incorrectos",
                showConfirmButton: false,
                timer: 1500,
              });
            }
          });
      }    
     

      
    },

  },
};
</script>

<style lang="scss">
body {
  background-color: #ffffff;
}
</style>
