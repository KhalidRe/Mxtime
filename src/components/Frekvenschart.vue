<script>
import { Line } from "vue-chartjs";

export default {
  extends: Line,
  props: {
    toChart: Array,
  },
  data() {
    return {
      i: 0,
      user: "",
      name: [],
      pointers: [],
      maxmimum: 0,
    };
  },
  created() {
    console.log("TOCHART", this.toChart);
    this.i = 0;
    this.names = [];
    this.pointer = [];

    for (this.i = 0; this.i < this.toChart.length; this.i++) {
      this.pointer.push(this.toChart[this.i].Antal);
      this.names.push(this.toChart[this.i].Datum);
    }

    this.maxmimum = Math.max(...this.pointer) + 1;
  },
  computed: {},
  mounted() {
    // Create new arrays to store the data

    this.gradient = this.$refs.canvas
      .getContext("2d")
      .createLinearGradient(0, 0, 0, 450);
    this.gradient2 = this.$refs.canvas
      .getContext("2d")
      .createLinearGradient(0, 0, 0, 0);
    this.gradient.addColorStop(0, "#1D80AB");
    this.gradient.addColorStop(1, "#31FFF3");

    this.renderChart(
      {
        labels: this.names,

        datasets: [
          {
            label: "Antal",

            backgroundColor: this.gradient,
            borderColor: "white",
            data: this.pointer,
            color: "red",
          },
        ],
      },

      {
        responsive: true,
        maintainAspectRatio: false,
        responsive: true,
        legend: {
          // display: false
        },
        layout: {
          padding: 10,
        },
        scales: {
          xAxes: [
            {
              gridLines: {
                display: true,
              },
            },
          ],
          yAxes: [
            {
              gridLines: {
                display: true,
              },
              ticks: {
                min: 0,
                max: this.maxmimum,
              },
            },
          ],
        },
      }
    );
  },
};
</script>
