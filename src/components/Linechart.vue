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
    };
  },
  created() {},
  mounted() {
    let names = [];
    let pointer = [];

    for (i = 0; i < this.toChart.length; i++) {
      pointer.push(this.toChart[i].result);
      names.push(this.toChart[i].Datum);
    }

    // Create new arrays to store the data

    this.gradient = this.$refs.canvas
      .getContext("2d")
      .createLinearGradient(0, 0, 0, 450);
    this.gradient2 = this.$refs.canvas
      .getContext("2d")
      .createLinearGradient(0, 0, 0, 0);
    this.gradient.addColorStop(0, "#1D80AB");
    this.gradient.addColorStop(1, "#31FFF3");

    var ratioArray = [];
    var labelsArray = [];
    for (var i = 0; i < pointer.length; i++) {
      // Then push our data to the new arrays
      labelsArray.push(names[i]);
      ratioArray.push(pointer[i]);
    }

    this.renderChart(
      {
        labels: names,

        datasets: [
          {
            label: "Avklarade projekt",

            backgroundColor: this.gradient,
            borderColor: "white",
            data: pointer,
            color: "red",
          },
        ],
      },
      { responsive: true, maintainAspectRatio: false }
    );

    console.log(this.toChart, "Hej LINECHART");
  },
};
</script>
