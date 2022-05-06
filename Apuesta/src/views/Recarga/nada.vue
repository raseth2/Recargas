<template>
   <div>
  <b-card>
    <div>     
      <div style="display:flex">
         <h4> <strong> Comprobante</strong>    </h4> <h5 style="margin-top:3px;margin-left:3px" class="font-weight-bold text-info" >{{Editar}}</h5>
      </div>
      <b-form-checkbox v-model="checked" name="check-button" switch>         
            <b v-if="checked">Ticket</b>
            <b v-else>A4</b>
      </b-form-checkbox>
    <hr> 
      <div class="form-row">       
          <b-form-group   style="margin: 0px 0px 0px 0px;"   class="col-md-6">
               <label class="control-label font-weight-bold text-info">Tipo Documento</label> 
               <div class="el-select border-left rounded-left border-info el-select">               
                <b-form-select
                id="input-1"
                name="input-1"  
                class="p-2 px-4 btn-xs ui dropdown"
                v-model="Comprobante.IdTipoDocumento"
                :options="tipoComprobantes"
                @change="GetSerie"                
                tabindex="0" >
                </b-form-select>                  
                 </div>
            </b-form-group>    

             <b-form-group  label="Almacen:"  class="col-md-2">
                <b-form-select
                id="input-2"
                name="input-2" 
                required
                class="p-2 px-4 btn-xs" 
                value-field="idAlmacen"
                v-model="Comprobante.IdAlmacen"
                text-field="descripcion"          
                :options="Almacen"
                tabindex="2"></b-form-select>               
            </b-form-group>  
        <b-form-group   label="Serie"    class="col-md-2" >      
            <b-form-select
               id="Serie"
               name="Serie"
               value-field="serie"
               text-field="serie" 
               v-model="Comprobante.Serie"
               :disabled='ActivarCampoSerie'
               :options="Series"
               class="p-2 px-4 btn-xs"
               tabindex="3">
          </b-form-select>      
            
        </b-form-group>
          <b-form-group    style="margin: 0px 0px 0px 0px;"  label="Numero"   class="col-md-2" >
          <b-form-input
           id="input-4"
           name="input-4"
           v-model="Comprobante.NumeroDocumento"
           type="text"
           class="p-2 px-4 btn-xs"
           autocomplete="off"
          :disabled='ActivarCampoNumero'
          tabindex="4">
          </b-form-input>
          <b-form-checkbox
                    id="checkbox-1"            
                    name="checkbox-1"
                    value="accepted"                 
                  v-model="campoNumero" >
                    Editar
                </b-form-checkbox>            
        </b-form-group>         
        </div>
      <div class="form-row" style="margin-top: -5px">
        <b-form-group  style="margin: 0px 0px 0px 0px;" class="col-md-6  el-input__inner" label-for="input-6" >
          <label class="control-label font-weight-bold text-info">Cliente</label> 
          <a href="#" class="text-center"   @click="DialogCliente=true"  v-b-tooltip.hover title="Agregar Nuevo Cliente" >   [+ Agregar]</a>       
            <auto-completado @Seleccionar="ObtenerCliente" :Nombre="Comprobante.NombreCliente"  v-bind:mensaje="estado"  v-on:Limpiar="limpiarTxt" tabindex="5">             
            </auto-completado>  
      </b-form-group>
        <b-form-group   style="margin: 0px 0px 0px 0px;" label="Direccion" class="col-md-6">                                        
              <b-form-input
                id="input-30"                
                v-model="Comprobante.Direccion"
                require
                class="p-2 px-4 btn-xs" tabindex="6"  >
                </b-form-input>                
            </b-form-group>
       </div>
      <div class="form-row" style="margin-top: -3px">   
      <b-form-group   label="Vendedor:"  class="col-md-3">
          <b-form-select
          id="CmbVendedor"
          name="CmbVendedor"    
          value-field="idVendedor"
          text-field="nombre"          
          :options="Vendedor"
          v-model="Comprobante.IdVendedor"         
          class="p-2 px-4 btn-xs" 
          aria-describedby="input-1-live-feedback"
          tabindex="7"></b-form-select>
      </b-form-group>
      <b-form-group  label="Tipo de Venta :"  class="col-md-3">
                <b-form-select
                  id="input-TipoVenta"
                  name="input-TipoVenta"    
                  value-field="idFormaVenta"
                  text-field="descripcion"
                  :options="TipoVenta"   
                  v-model="Comprobante.IdFormaVenta" 
                  @change="CambiarTipoVenta"
                tabindex="8"></b-form-select>
        </b-form-group>
       <b-form-group  label="Fecha Emision"   class="col-md-2">
        <b-form-input
          id="input-7"
          type="date"
          v-model="Comprobante.FechaDocumento"
          disabled 
          class="p-2 px-4 btn-xs" 
          required          
        tabindex="9"></b-form-input>
      </b-form-group>
    <b-form-group  label="Tipo Cambio"   class="col-md-2 ">           
        <b-form-input
          id="input-8"
          v-model.number="Comprobante.TipoCambio"
          required     
          class="p-2 px-4 btn-xs"  
        ></b-form-input>           
      </b-form-group>
      <b-form-group  label="Moneda"   class="col-md-2 ">     
        <b-form-select
          id="input-5" 
          name="input-5"  
          value-field="idCodigo"
          text-field="moneda"          
         :options="TipoMoneda"
          v-model="Comprobante.IdMoneda"
          ></b-form-select>        
      </b-form-group>
      </div>        
       <div  style="margin-top: -15px">           
              <articulo-buscar  @AgregarArticulo="AgregarDetalle" ></articulo-buscar>
        </div>  
        <b-card class="mt-3" header="Detalle"  header-text-variant="white"
                header-tag="header"
                header-bg-variant="primary"
                >       
         <table-comprobante v-bind:detalle="Comprobante.DetalleComprobantes" v-bind:total="subTotal" v-bind:igv1="Comprobante.ImporteIGV"  v-on:calcula="ReCalcular"  > </table-comprobante>              
      <div class="float-right">
        <br>
            <b-button v-if="id.IdTipoDocumento=='PV' " v-show="Comprobante.DetalleComprobantes.length>0" right type="button"
            style="margin-left:5px" variant="success" class="p-2 px-4 btn-xs"  @click="MensajeGuardar"  alt="Right" > <div class="float-left">
								<pulse-loader  v-if="loanding"  color="#F2E6E4" ></pulse-loader>
								</div>  Registrar</b-button>   

               <b-button v-else v-show="Comprobante.DetalleComprobantes.length>0" right type="button"
            style="margin-left:5px" variant="success" class="p-2 px-4 btn-xs"  @click="MensajeGuardar"  alt="Right" >  
            <div class="float-left">
								<pulse-loader  v-if="loanding"  color="#F2E6E4" ></pulse-loader>
								</div> Registrar</b-button>      
        </div>
        </b-card>   
      </div>
    </b-card>   
   <!--   <p>{{id}}</p> -->
    <cliente-nuevo @CerrarModal="CerrarModalCliente" :DialogCliente="DialogCliente"></cliente-nuevo>
    <articulo-modal v-model="modalArticulo"  v-on:Agrega-Tabla="RecibeArray">  </articulo-modal>   

  </div>
</template>

<script>

import AutoCompletado from '@/pages/Cliente/ClienteAutoComplete'
import ArticuloBuscar from '@/pages/Articulo/ArticuloBuscar' 
import ArticuloModal from '@/pages/Articulo/ArticuloModal';  
import ClienteNuevo from '@/pages/Cliente/ClienteNuevo';
import TableComprobante  from './TableComprobante'
import decode from 'jwt-decode'
import axios from  'axios'
import Vue from 'vue';

Vue.prototype.$eventHub = new Vue();

function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();
    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;
    return [year, month, day].join('-');
}
var today=formatDate(Date.now())

export default {
     components: {AutoCompletado,ArticuloBuscar,ArticuloModal,TableComprobante,ClienteNuevo},
    data(){
      return{
          //variables    
         
          DialogCliente:false,
          modalArticulo:false,
          SerieDocumento:'',
          campoNumero:false, 
          campoSerie:true,    
          estado:'limpieza',
          AnioEjercicio:'',
          NombreCliente:"",
          tokenUsuario:'',
          datosUsuario:'',
          loanding:false,          
          checked: false,
          RucEmpresa:'', 
          DiasVencido:0,
          editable:false,
          valida: 0,
          Editar:'',          
          //arrays
          ListaAutocomplete:[],
          tipoComprobantes:[],  
          TipoDocumentos:[],
          validaMensaje:[],          
          TipoMoneda:[],          
          TipoVenta:[],
          Vendedor:[],
          detalle:[],
          Almacen:[],
          Series:[],   
          //objetos
          id:{           
            IdTipoDocumento:"",
            NumeroDocumento:"",
            almacen:"",
            Serie:"",            
          },
          Comprobante: {
            IdAgencia:'TA01',
            IdTipoDocumento: '',
            Serie:'',           
            NumeroDocumento:'',
            IdAlmacen:'',
            NumeroPedido:'', 
            FechaDocumento:today,
            FechaVencimineto:today,
            FechaCrea:today,
            IdVendedor:'',
            IdCaja:'1',
            IdCliente:'',          
            NombreCliente: '', 
            Direccion:'',
            RUC:'',         
            IdFormaVenta:'',
            IdMoneda:'MN',  
            TipoCambio: 1,
            ImporteTotal:1,
            ImporteIGV:0,
            igv:0,
            Saldo:1,
            ImporteDescuento:1, 
            Destino:'',
            Estado:'V',
            UsuarioCrea:'',
            TipoOperacion:'GRAV',
            TipoAfecIGV:'G10',
            DebeHaber:'D',
            DetalleComprobantes:[]
         },
         ClsDataComprobante:{
             NumeroDocumento:'',
             TipoDcumento:'',
             RbtnTermico:'' ,
             ruc:'',
             anio:"",
             Serie :'',                         
         },      
      }
    },
    created(){
          this.GetTipoDocumento();             
          this.GetFormaVenta() 
          this.GetIGV()   
          this.Getmoneda()
          this.GetAlmacenes()
          this.GetVendedores()
          this.DatosEmpresa()
          this.$eventHub.$on('LimpiarCajas2', this.LimpiardeRegreso);
          //this.GetDatos()
      //  this.GetComprobante()
     },
     computed: {
       subTotal(){
                return this.Comprobante.DetalleComprobantes.reduce((total,item)=>{
                    return total+item.Cantidad*item.PrecioVenta
           },0)
        },
        ActivarCampoNumero: function(){
               return !this.campoNumero;
        }, 
        ActivarCampoSerie: function(){
              return !this.campoSerie;
        }
    },
    watch:{
         NombreCliente: function () {
        if(this.NombreCliente){
          //var found = this.ListaAutocomplete.find(e => e.idNombre=this.NombreCliente);            
            var id = this.NombreCliente.split("-")
            this.Comprobante.IdCliente = id[0]
            this.Comprobante.NombreCliente = id[1]
            var Cliente = this.ListaAutocomplete.filter(function(elem){
                if(elem.idCliente == id[0]) return elem;
            });
            this.Comprobante.RUC = Cliente[0].RUC
            this.Comprobante.Direccion = Cliente[0].direccion
        }else{
            this.Comprobante.NombreCliente = ""
            this.Comprobante.IdCliente = ""  
            this.Comprobante.Direccion=""      
            this.Comprobante.RUC = ""
          
        }        
      }
    },
    mounted(){
      this.GetDatos()
      if(localStorage.token) this.tokenUsuario = localStorage.token;
        this.Comprobante.UsuarioCrea=this.datosUsuario.idUsuario; 
        this.datosUsuario=decode(this.tokenUsuario) 
        
    },
    methods:{
      DatosEmpresa(){
           axios({
                   method: 'get',
                   url: 'Entidad/GetEntidad',
                   data: {}
            })
             .then(response => { 
            //   console.log(response.data);
                 this.ClsDataComprobante.anio=response.data.anioEjercicio;
                 this.ClsDataComprobante.ruc=response.data.ruc;       
                 this.AnioEjercicio=response.data.anioEjercicio; 
                 this.RucEmpresa=response.data.ruc;  
          })
       },
       ValidarForm(){
         var estado = true;
         if(this.Comprobante.IdCliente.length<8){ this.EstadoNroDocumento=estado=false; } else { this.EstadoNroDocumento=true;  }
         if(this.Comprobante.NombreCliente.length<=3){ this.EstadoNombre=estado=false; } else { this.EstadoNombre=true; } 
         return estado;
       },
       ValidarCampos(){
           this.valida=0;
           this.validaMensaje=[];
           if (this.Comprobante.NombreCliente.length==0){
                this.validaMensaje.push("El nombre debe tener más de 3 caracteres y menos de 50 caracteres.");
           }
           if(this.Comprobante.IdAlmacen==""){
              this.validaMensaje.push("Falta almacen");
           }
        //   if (this.Comprobante.IdTipoDocumento.length==0){
          //      this.validaMensaje.push("Falta Llenar");
           //}
           //Comprobante.IdTipoDocumento
           if (this.validaMensaje.length){
               this.valida=1;
           }
          return this.valida;

        },     
       AgregarDetalle(datos){         
          // PrecioTotal recien lo puse
          datos.item= this.Comprobante.DetalleComprobantes.length+1  
          this.Comprobante.DetalleComprobantes.push(
            {                
                PrecioVenta: datos.PrecioUnitario,
                Descripcion: datos.Descripcion,
                PrecioTotal:datos.PrecioTotal,
                ImporteMN: datos.PrecioTotal,
                IdArticulo:datos.IdArticulo,                
                Cantidad: datos.Cantidad,  
                Unidad: datos.Unidad,
            })
          this.ReCalcular()
       },
       GetDatos(){
          var id = this.$route.params.id           
          if(id){         
            this.editable = true
            var val = id.split("-"); 
            this.id.NumeroDocumento=val[3]
            this.id.IdTipoDocumento=val[1]
            this.id.almacen = val[0]            
            this.id.Serie=val[2]
            
          }          
          if(this.id.IdTipoDocumento=="PV")
           {
              this.GetPreventa()
           }           
           else if (this.id.IdTipoDocumento=="BV" || this.id.IdTipoDocumento=="FT" ){
               this.GetComprobante()
           }
           else{
             //algun mensaje .
           }
            
       },
       //recibe para modificar comprobamte
       GetComprobante(){
        
          this.Editar="Editar";  
          this.campoSerie=false; 
          axios({
              method: 'post',
              url: 'Comprobante/GetDetalle',
              data: {
                IdAlmacen:this.id.almacen,
                idTipoDocumento:this.id.IdTipoDocumento,
                NumeroDocumento:this.id.NumeroDocumento,
                Serie:this.id.Serie,
              }
          })
          .then(response => {          
               // console.log(response.data);
               this.$eventHub.$emit('nombre-cliente', response.data.nombreCliente);
                this.Comprobante.NumeroDocumento=response.data.numeroDocumento; 
                this.Comprobante.NombreCliente=response.data.nombreCliente  
                this.Comprobante.ImporteTotal=response.data.importeTotal    
                this.Comprobante.IdFormaVenta=response.data.idFormaVenta         
                this.Comprobante.IdAgencia=response.data.idAgencia
                this.Comprobante.Direccion=response.data.direccion
                this.Comprobante.IdVendedor=response.data.idVendedor
                this.Comprobante.IdCliente=response.data.idCliente   
                this.Comprobante.IdAlmacen=response.data.idAlmacen
                this.Comprobante.IdMoneda=response.data.idMoneda
                this.Comprobante.TipoCambio=response.data.tipoCambio               
                this.Comprobante.ImporteIGV=response.data.importeIGV               
                this.Comprobante.igv=response.data.igv
                this.Comprobante.RUC=response.data.ruc  
                this.Comprobante.Serie=response.data.serie;
                this.SerieDocumento=response.data.serie;
                this.Comprobante.TipoOperacion='GRAV'
                this.Comprobante.TipoAfecIGV='G10'
              // Cargar detalle comprobante
               response.data.detalleComprobantes.forEach(elem => {
                this.Comprobante.DetalleComprobantes.push({
                  PrecioUnitario:elem.importeMN/elem.cantidad, 
                  PrecioVenta:elem.importeMN/elem.cantidad,
                  IdArticulo:elem.idArticulo, 
                  Descripcion:elem.descripcion, 
                  Cantidad:elem.cantidad,                  
                  ImporteMN:elem.importeMN, 
                  Unidad:elem.unidad,  
                  Item:elem.item,
                })
              });
             
         })  
       },
       GetPreventa(){
       
           axios({
              method: 'post',
              url: 'PreVenta/GetDetalle',
              data: {
                IdAlmacen:this.id.almacen,
                idTipoDocumento:this.id.IdTipoDocumento,
                NumeroDocumento:this.id.NumeroDocumento,
                Serie:this.id.Serie,
              }
          })
          .then(response => {
            this.$eventHub.$emit('nombre-cliente', response.data.nombreCliente);
                this.Comprobante.IdAgencia=response.data.idAgencia
                this.Comprobante.Direccion=response.data.direccion
                this.Comprobante.IdVendedor=response.data.idVendedor
                this.Comprobante.IdCliente=response.data.idCliente 
                this.Comprobante.NombreCliente=response.data.nombreCliente                
                this.Comprobante.RUC=response.data.ruc
                this.Comprobante.IdAlmacen=response.data.idAlmacen
                this.Comprobante.IdMoneda=response.data.idMoneda
                this.Comprobante.TipoCambio=response.data.tipoCambio
                this.Comprobante.ImporteTotal=response.data.importeTotal
                this.Comprobante.ImporteIGV=response.data.importeIGV
                this.Comprobante.igv=response.data.igv
                this.Comprobante.IdFormaVenta=response.data.idFormaVenta
                
              // Cargar detalle
                response.data.detallePreVenta.forEach(elem => {
                this.Comprobante.DetalleComprobantes.push({
                  IdArticulo:elem.idArticulo, 
                  Descripcion:elem.descripcion, 
                  Cantidad:elem.cantidad,
                  PrecioUnitario:elem.importeMN/elem.cantidad, 
                  PrecioVenta:elem.importeMN/elem.cantidad,
                  ImporteMN:elem.importeMN, 
                  Unidad:elem.unidad,  
                  Item:elem.item,
                })
              });
         })    
        },
       ReCalcular(){
          var suma=0
          this.Comprobante.DetalleComprobantes.forEach(element => {
            element.ImporteMN=element.Cantidad* element.PrecioVenta
            suma = suma + element.ImporteMN
          });
          this.Comprobante.ImporteTotal = suma
          this.Comprobante.ImporteIGV=suma*(this.Comprobante.igv/100)

       },
       MensajeGuardar(){
          if (this.ValidarCampos()){            
              this.FaltaCampos()
              return;
          }
          var token= this.tokenUsuario;;
          // console.log(token)
           if(token=="" || token==null){
                 this.$swal.fire({
                          title: '<strong>Mensaje</strong>',
                          icon: 'info',
                          html:
                            'No estas Logeado en el Sistema',             
                          showCloseButton: true,
                          showCancelButton: true,
                          focusConfirm: false,
                          showConfirmButton: false,
                          cancelButtonText:
                            '<i class="fa fa-thumbs-down"></i>',
                          cancelButtonAriaLabel: 'Thumbs down'
                   })
            }
            else{
                if(this.editable){
                    this.$swal({
                    title: 'Desea Editar ?',                
                    showCancelButton: true,
                    confirmButtonText: `Si`,                  
                      }).then((result) => {                  
                      if (result.isConfirmed) {
                          this.EditarComprobante();                    
                      } else if (result.isDenied) {
                        this.$swal('No Editado', '', 'info')
                      }
                    })
                }else{
                    this.$swal({
                    title: 'Desea Registrar ?',                
                    showCancelButton: true,
                    confirmButtonText: `Si`,                  
                    }).then((result) => {                  
                      if (result.isConfirmed) {
                          this.RegistrarComprobante();                    
                    } else if (result.isDenied) {
                        this.$swal('No Registrado', '', 'info')
                    }
                  })
               }                  
          }              
       },
       Confirmacion(mensaje){
          this.$swal({
              position: 'top-end',
              icon: 'success',
              title: mensaje,
              text:'texto',
              showConfirmButton: false,
              timer: 3000
              })
       },
       MemsajeGenerarXml(numero){
           this.$swal.fire({
            title: 'Desea Generar XML ?',
            text:"Comprobante Registrado "+ numero,
            showDenyButton: true,
            showCancelButton: true,
            confirmButtonText: `Si`,
            denyButtonText: `No`,
          }).then((result) => {
            /* Read more about isConfirmed, isDenied below */
            if (result.isConfirmed) {             
                this.GenerarXml();
            } else  {
                this.$swal.fire('OK', '', )
                this.LimpiarCampos()
            }
          })
       },         
       GenerarXml(){    
          let me =this;   
                me.$swal({ title: 'Generando Xml',allowOutsideClick: false});
                me.$swal.showLoading();
                 axios({
                      method: 'post',  
                      url: me.RutaApiXml+'api/GenerarXml/CrearXml',
                      data:me.ClsDataComprobante,
                  })
                  .then(response => {
                        me.$swal.close();                      
                       // console.log(response)
                       var estado =response.data.mensaje
                       var error =response.data.error;
                       var mensaje =response.data.mensaje;
                       me.Creado(error,estado,mensaje);
                       //me.Creado();
                       me.LimpiarCampos()
                  }).catch(function (error) {
                      console.log(error);
                      me.$swal.close(); 
               }) 
       },
       Creado(error,estado,mensaje){ 
             if  (error==false){
                  // this.$swal.fire('Resultado ', estado+ "! "+mensaje)
                  this.GetlistaTipoDocumento()           
                  this.$swal.fire({
                  title: 'Exito!',
                  text: mensaje,             
                  showCancelButton: true,
                  confirmButtonColor: '#3085d6',
                  cancelButtonColor: '#d33',
                  confirmButtonText: 'Ver'
                }).then((result) => {
                  if (result.isConfirmed) {
                      this.VerPdf()
                  }
                })

             }else if (error==true){
                   this.$swal.fire(' Resultado ', estado+"! "+mensaje)
            }  
       },
       VerPdf(){  
                var tdSunat;    
                var i;  
                for(i = 0;i< this.TipoDocumentos.length;i++){            
                        if(this.TipoDocumentos[i].idTipoDocumento==this.ClsDataComprobante.TipoDcumento){
                           tdSunat=this.TipoDocumentos[i].tdSunat;              
                            break;
                        }  
                    }   
                    var ruc =this.RucEmpresa; 
                    var OComprobante =this.ClsDataComprobante.Serie+"-"+this.ClsDataComprobante.NumeroDocumento;
                    var filename=ruc+"-"+tdSunat+"-"+OComprobante+".pdf";  
                    //http://127.127.0.1/apixml/sigma/20449213166/pdf/20449213166-01-F001-000001705041733200.pdf                
                    let ruta = this.RutaDocumento+"sigma/"+this.RucEmpresa+"/pdf/"+filename;             
                    window.open(ruta, '_blank');
            
       }, 
       RegistrarComprobante(){
                let me =this;                
                me.loanding=true;
                var datos;
                me.Comprobante.TipoOperacion='GRAV'
                me.Comprobante.TipoAfecIGV='G10'  
                axios.post('Comprobante/SetComprobante',me.Comprobante,{ emulateJSON: true})                
                .then(function(response){
                    var resul=response.data.mensaje;                   
                    if(resul=="Hubo Un error")
                    {
                        me.$swal({
                          position: 'top-end',
                          icon: 'error',
                          title: 'Ups',
                          text:"Error al Registrar Comprobante",
                          showConfirmButton: false,
                          timer: 4000
                          })
                          me.loanding=false;
                    } 
                    else{
                        me.$swal({
                          position: 'top-end',
                          icon: 'success',
                          title: 'Registrado',
                          text:"Numero de Documento :"+response.data.numeroDocumento,
                          showConfirmButton: false,
                          timer: 4000
                       })                                    
                       datos=response.data.numeroDocumento.split('-');
                       me.ClsDataComprobante.TipoDcumento=datos[0];
                       me.ClsDataComprobante.Serie=datos[1];
                       me.ClsDataComprobante.NumeroDocumento=datos[2];     
                      // false  es -> Pdf ||  true -> ticket
                       me.ClsDataComprobante.RbtnTermico=me.checked;                       
                       me.loanding=false;
                       me.MemsajeGenerarXml(response.data.numeroDocumento)                      
                    }
                    // Actualizar preventa
                    // if(me.id.idTipoDocumento=="PV"){ Estaba con la i minuscula We
                    if(me.id.IdTipoDocumento=="PV"){                  
                        axios.post('Preventa/UpdateEstado',me.id,{ emulateJSON: true})
                    } 
                }).catch(function(error){
                    console.log(error);
                     me.loanding=false;
             });
       },
       EditarComprobante(){
              let me = this;
               me.loanding=true;
               me.Comprobante.Serie=me.SerieDocumento
               me.Comprobante.TipoOperacion='GRAV'
               me.Comprobante.TipoAfecIGV='G10'
               axios.post('Comprobante/UpdateComprobante',me.Comprobante,{ emulateJSON: true})                
                .then(function(response){                                  
                     //console.log(response.data);
                     me.Confirmacion(response.data.msg);
                     me.loanding=false;
                     me.editable = false;
                     me.campoSerie=true;
                     me.LimpiarCampos();
                     me.Comprobante.Serie=me.Series[0].serie
                }).catch(function(error){
                    console.log(error);
                     me.loanding=false;
              });
       },  
       RecibeArray(product){
           this.Comprobante.DetalleComprobantes.push(JSON.parse(JSON.stringify(product)));  
       },
       EstadoPreventa(datos){
             axios({
                method: 'post',
                url: 'TipoMoneda/GetLista',
                data: {}
              })
              .then(response => {
                  this.TipoMoneda = response.data
           })
       },
       ObtenerCliente(val){         
          this.Comprobante.IdCliente=val.idCliente
          this.Comprobante.NombreCliente = val.nombre
          this.Comprobante.RUC = val.RUC
          this.Comprobante.Direccion = val.direccion   
       },
       GetIGV(){
         axios({
            method: 'post',
            url: 'IGV/GetFactor',
            data: {}
            })
            .then(response => {
                this.Comprobante.igv = response.data.factor*100
                this.DescIGV = response.data.descripcion               
           })
       },
       GetSerie(Tipo){       
            axios({
                method: 'post',
                url: 'Numeracion/GetSerie',
                data: {IdTipoDocumento:Tipo}
            })
            .then(response => {
                this.Series = response.data;
               // console.log(response.data);
                this.Comprobante.Serie=this.Series[0].serie
              //    this.GetNumero(Tipo,this.Series[0].serie)
               // if(this.Series.length==1){
                 //   this.Comprobante.Serie=this.Series[0].serie
                //}
            })
       },
       CambiodeFecha(val){
         let fecha =String(val).split("-")
         var date = new Date(fecha[0],fecha[1],fecha[2]);
        //salert(date)
         date.setDate(date.getDate() + this.DiasVencido)
         this.Comprobante.FechaVencimineto= formatDate(date)
       //  console.log( this.Comprobante.FechaVencimiento);
       },
       Getmoneda(){
            axios({
                method: 'post',
                url: 'TipoMoneda/GetLista',
                data: {}
            })
            .then(response => {
                this.TipoMoneda = response.data
            })
        },
       GetNumero(Tipo,Serie){
         axios({
                method: 'post',
                url: 'Numeracion/GetNumero',
                data: {IdTipoDocumento:Tipo,Serie:Serie}
            })
            .then(response => {
               // this.Series = response.data;
              this.Comprobante.NumeroDocumento=response.data.numeroActual+1;                      
           })
       },
       GetlistaTipoDocumento(){
              let me=this;          
              axios.post('TipoDocumento').then(function(response){                      
                  me.TipoDocumentos=response.data;  
                }).catch(function(error){
                  console.log(error);
           });
       },
       GetTipoDocumento(){
           let me=this;
             var tipoDcumento=[];
             axios.post('TipoDocumento',).then(function(response){                      
             tipoDcumento=response.data;            
             tipoDcumento.map(function(x){
                   me.tipoComprobantes.push({text: x.tipoDocumento,value:x.idTipoDocumento});
               });             
             me.Comprobante.IdTipoDocumento=tipoDcumento[0].idTipoDocumento
             me.GetSerie(tipoDcumento[0].idTipoDocumento)
            }).catch(function(error){
             console.log(error);
         });
       },
       GetFormaVenta(){
            axios({
                method: 'post',
                url: 'FormaVenta/GetLista',
                data: {}
            })
            .then(response => {              
                this.TipoVenta = response.data
                if(this.TipoVenta.length>=1){
                    this.Comprobante.IdFormaVenta=this.TipoVenta[0].idFormaVenta
                }                
            })
        },        
       GetVendedores(){
            axios({
                method: 'post',
                url: 'Vendedor/GetLista',
                data: {}
            })
            .then(response => {
              this.Vendedor = response.data;              
              if(this.Vendedor.length>0){
                 this.Comprobante.IdVendedor=this.Vendedor[0].idVendedor
                 // this.Comprobante.UsuarioCrea=this.Vendedor[0].idVendedor
                // this.Comprobante.UsuarioCrea="001"
              }
            //  if(this.Almacen.length==1){
                //    this.Comprobante.IdVendedor=this.Vendedor[0].idVendedor                   
              // }
          })
       },
       GetAlmacenes(){
            axios({
                method: 'post',
                url: 'Almacen/GetLista',
                data: {}
            })
            .then(response => {
                this.Almacen = response.data;
                this.Comprobante.IdAlmacen=this.Almacen[0].idAlmacen              
                //if(this.Almacen.length==1){
                  //  this.Comprobante.idAlmacen=this.Almacen[0].idAlmacen
                //}
           })
       },
       CambiarTipoVenta(val){       
         var valObj = this.TipoVenta.filter(function(elem){
            if(elem.idFormaVenta == val) return elem;
          });
        var date = new Date();
        date.setDate(date.getDate() + parseInt(valObj[0].diasVencidos))
        this.Comprobante.FechaVencimineto= formatDate(date)
       }, 
       CerrarModalCliente() {
            this.DialogCliente = false          
       }, 
       AbrirModalArticulo() {      
          this.modalArticulo = true;
       },
       makeToast(variant = null) {
            this.$bvToast.toast('Comprobante Registrado', {
              title: `Registrado`,
              variant: variant,
              solid: true
          })
        },
       makeToast1(variant = null) {
            this.$bvToast.toast('No Registro', {
              title: `Error`,
              variant: variant,
              solid: true
          })
        },
       limpiarTxt(){
           this.Comprobante.NombreCliente="";
        },
       FaltaCampos(){
            this.$swal.fire({
              title: '<strong>Ups</strong>',
              icon: 'info',
              html:
                'Falta Llenar campos',               
            })
       },     
       LimpiardeRegreso(){
        
          this.Comprobante.DetalleComprobantes=[]
          this.Comprobante.DetallePreVenta=[]
          this.$eventHub.$emit('LimpiarCaja')
          this.Comprobante.ImporteTotal = 0
          this.Comprobante.ImporteIGV=0
          this.Comprobante.NombreCliente=""
          this.Comprobante.Direccion="";
          this.id.NumeroDocumento=false;
          this.id.IdTipoDocumento="";
          this.id.NumeroDocumento="";
          this.editable = false;
          this.campoSerie=true
          this.cantidaFilas=0
          this.FactorIGV=1
          this.Editar='';  
          this.id.almacen="";          
          this.id.Serie=""; 
          
       },
       LimpiarCampos(){
        this.Comprobante.FechaVencimineto=new Date().toISOString().substr(0, 10);
        this.Comprobante.FechaDocumento=new Date().toISOString().substr(0, 10),
        this.Comprobante.NumeroDocumento='';
        this.Comprobante.NumeroPedido='';  
        this.Comprobante.IdCaja='1';
        this.Comprobante.IdCliente='';
        this.Comprobante.NombreCliente='';
        this.Comprobante.Direccion='';
        this.Comprobante.RUC='';       
        this.Comprobante.IdMoneda='MN';
        this.Comprobante.ImporteTotal=1;
        this.Comprobante.ImporteIGV=0;
        this.Comprobante.igv=0;
        this.Comprobante.Saldo=0;
        this.Comprobante.ImporteDescuento=1;
        this.Comprobante.Destino='';
        this.Editar='';
        this.Comprobante.DetalleComprobantes=[];  
        this.$eventHub.$emit('LimpiarCaja')
       }
   }
}
</script>