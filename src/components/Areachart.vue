<script>
import { Line } from "vue-chartjs";

export default {
  data() {
    return {
      project: "",
      edeadline: "",
      ecompleted: "",
      eauthor: "",
      eprecentage: "",
      eworker: "",
      allprojects: [],
      cnartdata: "",
      i: 0,
    };
  },
  extends: Line,
  created() {
    fetch("http://192.168.1.138:3000/viewprojects")
      .then((response) => response.json())
      .then((result) => {
        this.project = result;
        for (this.i = 0; this.i <= result.length; this.i++) {}
      });
    fetch("http://192.168.1.138:3000/getusers")
      .then((response) => response.json())
      .then((result) => {
        this.user = result;
      });
    fetch("http://192.168.1.138:3000/chartdata")
      .then((response) => response.json())
      .then((result) => {
        this.chartdata = result;
      });
  },

  data() {
    return {
      gradient: null,
      gradient2: null,
    };
  },
  mounted() {
    this.gradient = this.$refs.canvas
      .getContext("2d")
      .createLinearGradient(0, 0, 0, 450);
    this.gradient2 = this.$refs.canvas
      .getContext("2d")
      .createLinearGradient(0, 0, 0, 450);

    this.gradient.addColorStop(0, "rgba(255, 0,0, 0.5)");
    this.gradient.addColorStop(0.5, "rgba(255, 0, 0, 0.25)");
    this.gradient.addColorStop(1, "rgba(255, 0, 0, 0)");

    this.gradient2.addColorStop(0, "rgba(0, 231, 255, 0.9)");
    this.gradient2.addColorStop(0.5, "rgba(0, 231, 255, 0.25)");
    this.gradient2.addColorStop(1, "rgba(0, 231, 255, 0)");

    this.renderChart(
      {
        labels: [
          "January",
          "February",
          "March",
          "April",
          "May",
          "June",
          "July",
        ],
        datasets: [
          {
            label: "Data One",
            borderColor: "#FC2525",
            pointBackgroundColor: "white",
            borderWidth: 1,
            pointBorderColor: "white",
            backgroundColor: this.gradient,
            data: [1, 2, 3, 4, 5, 6, 7],
          },
          {
            label: "Data Two",
            borderColor: "#05CBE1",
            pointBackgroundColor: "white",
            pointBorderColor: "white",
            borderWidth: 1,
            backgroundColor: this.gradient2,
            data: [6, 6, 6, 6, 6, 6, 6],
          },
        ],
      },
      { responsive: true, maintainAspectRatio: false }
    );
  },
  mounted() {
    var start = new Date(2021, 11, 4),
      end = new Date(2021, 11, 6),
      today = new Date();
    var q = Math.abs(today - start);
    var d = Math.abs(end - start);
    alert("Rounded: " + Math.round((q / d) * 100) + "%");
    alert("Fraction: " + (q / d) * 100 + "%");
  },
};
</script>
