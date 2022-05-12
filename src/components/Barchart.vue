<script>
import { Bar } from "vue-chartjs";

export default {
  extends: Bar,
  data() {
    return {
      i: 0,
      user: "",
      name: [],
      pointers: [],
    };
  },
  props: {
    width: {
      type: Number,
      default: 10,
    },
  },
  created() {
    fetch("https://flexn.se:3000/getusers")
      .then((response) => response.json())
      .then((result) => {
        this.user = result;

        for (this.i = 0; this.i < this.user.length; this.i++) {
          this.pointers.push(this.user[this.i].Active);
          this.name.push(this.user[this.i].Name);
        }
      });
  },
  mounted() {
    let names = [];
    let pointer = [];
    fetch("https://flexn.se:3000/getusers")
      .then((response) => response.json())
      .then((result) => {
        let user = result;
        for (i = 0; i < user.length; i++) {
          pointer.push(user[i].Active);
          names.push(user[i].Name);
        }

        // Create new arrays to store the data

        this.gradient = this.$refs.canvas
          .getContext("2d")
          .createLinearGradient(0, 0, 0, 450);
        this.gradient2 = this.$refs.canvas
          .getContext("2d")
          .createLinearGradient(0, 0, 0, 450);
        this.gradient.addColorStop(0, "#00AFD6");
        this.gradient.addColorStop(1, "#007DC6");

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
                label: "Aktiv i projekt",
                backgroundColor: this.gradient,
                data: pointer,
                font: this.font,
              },
            ],
          },

          {
            responsive: true,
            maintainAspectRatio: false,
          }
        );
      });
  },
};
</script>
