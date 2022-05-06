<template>
  <div>
    <h6>Redes Sociales</h6>
    <a-row :gutter="24" v-if="esAdministrador || esPromotor">
      <a-col
        :span="24"
        :lg="12"
        :xl="6"
        class="mb-24"
        v-for="item in itemsocial"
        :key="item.social_id"
      >
        <WidgetCounter
          :title="item.name"
          :value="item.Suma"
          :icon="icon"
          :suffix="item.total"
          prefix="S/ "
          :status="status"
        ></WidgetCounter>
      </a-col>
    </a-row>

    <h6>Bancos</h6>
    <a-row :gutter="24" v-if="esAdministrador || esPromotor">
      <a-col
        :span="24"
        :lg="12"
        :xl="6"
        class="mb-24"
        v-for="item in itembank"
        :key="item.bank_id"
      >
        <WidgetCounter
          :title="item.description"
          :value="item.total"
          :icon="icon"
          suffix=""
          prefix=""
          :status="status"
        ></WidgetCounter>
      </a-col>
    </a-row>

    <a-row :gutter="24" type="flex" align="stretch" v-else>
      <a-col :span="24" :lg="24" class="mb-24">
        <a-carousel autoplay>
          <div>
            <img alt="example" style="width: 100%" src="images/panel2.png" />
          </div>
          <div>
            <img alt="example" style="width: 100%" src="images/panel1.png" />
          </div>
          <div>
            <img alt="example" style="width: 100%" src="images/panel3.png" />
          </div>
        </a-carousel>
        <!-- <TablaMensaje  :data="itemmensajes" :columns="table1Columns"  ></TablaMensaje>      -->
      </a-col>
    </a-row>
    <a-card :bordered="false" class="dashboard-bar-line header-solid" v-if="esAdministrador || esPromotor">
      <template #title>
        <h6>Recarga por mes</h6>
      </template>
      <template #extra>
        <a-badge color="primary" class="badge-dot-primary" text="Traffic" />
      </template>
      <chart-line :height="310" :data="lineChartData"></chart-line>
    </a-card>
  </div>
</template>

<script>
import axios from "axios";
const Swal = require("sweetalert2");
import { mapState } from "vuex";

// Bar chart for "Active Users" card.
import CardBarChart from "../components/Cards/CardBarChart";

// Line chart for "Sales Overview" card.
import CardLineChart from "../components/Cards/CardLineChart";
import ChartLine from "../components/Charts/ChartLine";

// Counter Widgets
import WidgetCounter from "../components/Widgets/WidgetCounter";

// "Projects" table component.
import CardProjectTable from "../components/Cards/CardProjectTable";

// Order History card component.
import CardOrderHistory from "../components/Cards/CardOrderHistory";

// Information card 1.
import CardInfo from "../components/Cards/CardInfo";

// Information card 2.
import CardInfo2 from "../components/Cards/CardInfo2";

import TablaMensaje from "../components/Tablas/TablaMensaje";

export default {
  components: {
    CardBarChart,
    CardLineChart,
    WidgetCounter,
    CardProjectTable,
    CardOrderHistory,
    CardInfo,
    CardInfo2,
    TablaMensaje,
    ChartLine,
  },
  data() {
    return {
      lineChartData: {
        labels: [],
        datasets: [
          {
            label: "Recargas",
            borderWidth: 0,
            pointRadius: 0,
            borderColor: "#1890FF",
            borderWidth: 3,
            data: [],
          },
        ],
      },
      status: "success",
      itemsocial: [],
      itembank: [],

      icon: `
						<svg width="22" height="22" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M9 6C9 7.65685 7.65685 9 6 9C4.34315 9 3 7.65685 3 6C3 4.34315 4.34315 3 6 3C7.65685 3 9 4.34315 9 6Z" fill="#111827"/>
							<path d="M17 6C17 7.65685 15.6569 9 14 9C12.3431 9 11 7.65685 11 6C11 4.34315 12.3431 3 14 3C15.6569 3 17 4.34315 17 6Z" fill="#111827"/>
							<path d="M12.9291 17C12.9758 16.6734 13 16.3395 13 16C13 14.3648 12.4393 12.8606 11.4998 11.6691C12.2352 11.2435 13.0892 11 14 11C16.7614 11 19 13.2386 19 16V17H12.9291Z" fill="#111827"/>
							<path d="M6 11C8.76142 11 11 13.2386 11 16V17H1V16C1 13.2386 3.23858 11 6 11Z" fill="#111827"/>
						</svg>`,
    };
  },
  computed: {
    ...mapState(["url_base", "url_base2"]),
    esAdministrador() {
      return localStorage.getItem("tipousuario") == "Administrador";
    },
    esPromotor() {
      return localStorage.getItem("tipousuario") == "Promotor";
    },
    esCliente() {
      return localStorage.getItem("tipousuario") == "Cliente";
    },
  },
  created() {
    this.ListMonth();
  },
  mounted() {
    this.ListSocialNetwork();
    this.ListBank();
  },
  methods: {
    ListSocialNetwork() {
      let me = this;
      let url = me.url_base2 + "recharge/social";
      axios({
        method: "GET",
        url: url,
      })
        .then(function (response) {
          me.itemsocial = response.data.result;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    ListBank() {
      let me = this;
      let url = me.url_base2 + "recharge/bank";
      axios({
        method: "GET",
        url: url,
      })
        .then(function (response) {
          me.itembank = response.data.result;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    ListMonth() {
      let me = this;
      let url = me.url_base2 + "recharge/month";
      axios({
        method: "GET",
        url: url,
      })
        .then(function (response) {
          let lables = response.data.result;
          for (let index = 0; index < lables.length; index++) {
            me.lineChartData.labels.push(lables[index].months);
            me.lineChartData.datasets[0].data.push(
              parseInt(lables[index].amount)
            );

            console.log(lables[index].amount);
          }
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
};
</script>
<style scoped>
/* For demo */
.ant-carousel :deep(.slick-slide) {
  text-align: center;
  height: 160px;
  line-height: 160px;
  background: #364d79;
  overflow: hidden;
}

.ant-carousel :deep(.slick-slide h3) {
  color: #fff;
}
</style>
<style lang="scss"></style>
