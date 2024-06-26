<template>
  <div id="app">
    <div class="max-w-5xl p-6 pt-12 mx-auto">
      <div class="border-b border-gray-800 pt-8 pb-16">
        <div class="font-normal text-4xl text-white">@josephuspaye/timer</div>
        <p class="text-gray-400 text-base mt-4 text-xl">
          A small and smooth (60-fps) countdown timer and stopwatch for Vue and
          vanilla JS.
          <a
            href="https://github.com/JosephusPaye/timer"
            rel="noopener"
            target="_blank"
            class="
              pb-1
              inline-flex
              border-b border-gray-500
              leading-none
              text-gray-500
              hover:text-gray-100
              focus:text-gray-100
              hover:border-gray-100
              focus:border-gray-100
            "
            >View documentation</a
          >.
        </p>
      </div>

      <div class="flex flex-col lg:flex-row min-w-0 mt-16">
        <div class="flex h-10">
          <ToggleButton id="countdown" :value.sync="type"
            >Countdown</ToggleButton
          >
          <ToggleButton id="stopwatch" :value.sync="type"
            >Stopwatch</ToggleButton
          >
        </div>

        <div class="h-10 mt-4 lg:mt-0 lg:ml-3">
          <CheckButton :checked.sync="allowOverflow"
            >Allow overflow</CheckButton
          >
        </div>

        <div class="mt-4 lg:mt-0 lg:ml-3 lg:flex lg:items-center h-10">
          <span
            class="
              bg-gray-800
              px-4
              inline-flex
              items-center
              justify-center
              text-white
              h-full
              cursor-default
            "
            >Length</span
          >
          <!--
2604
         -->
          <input
            type="number"
            step="1000"
            v-model.number="length"
            class="
              ml-auto
              w-32
              px-3
              py-1
              bg-gray-700
              text-black
              h-full
              text-white
            "
          />
        </div>
      </div>

      <div class="mt-4 italic text-gray-600 text-xl">
        See browser console for timer events.
      </div>

      <div class="mt-8">
        <Timer
          ref="timer"
          :type="type"
          :allowOverflow="allowOverflow"
          :length="length"
          @done="onDone"
          @start="onStart"
          @stop="onStop"
          @reset="onReset"
          @pause="onPause"
          @resume="onResume"
          @overflow="onOverflow"
          v-slot="{ time, state, isOverflowed, isDone }"
        >
          <div>
            <div
              class="text-6xl font-mono font-thin"
              :class="[
                isOverflowed ? 'text-red-500' : 'text-gray-400',
                isDone ? 'flash' : '',
              ]"
            >
              {{ time.h }}:{{ time.m }}:{{ time.s }}:{{ time.ms }}
            </div>

            <div class="mt-6">
              <Button @click="toggle" color="primary" class="mr-1">
                {{
                  state === "stopped"
                    ? "Start"
                    : state === "running"
                    ? "Pause"
                    : "Resume"
                }}
              </Button>
              <Button @click="reset">Reset</Button>
            </div>
          </div>
        </Timer>
      </div>

      <div class="mt-8 text-gray-700 text-sm">
        Created by
        <a
          class="underline hover:text-gray-200 focus:text-gray-200"
          href="https://twitter.com/JosephusPaye"
          target="_blank"
          rel="noopener"
          >Josephus Paye II</a
        >
        for
        <a
          class="underline hover:text-gray-200 focus:text-gray-200"
          href="https://twitter.com/JosephusPaye/status/1214853295023411200"
          target="_blank"
          rel="noopener"
          >#CreateWeekly</a
        >. Available on
        <a
          class="underline hover:text-gray-200 focus:text-gray-200"
          href="https://github.com/JosephusPaye/timer"
          target="_blank"
          rel="noopener"
          >GitHub</a
        >.
      </div>
    </div>
  </div>
</template>

<script>
import { TimerVue as Timer } from "@josephuspaye/timer";
import CheckButton from "./CheckButton.vue";
import ToggleButton from "./ToggleButton.vue";
import Button from "./Button.vue";
export default {
  name: "App",
  components: { CheckButton, ToggleButton, Button, Timer },
  data() {
    return {
      type: "countdown",
      allowOverflow: false,
      length: 5 * 1000,
    };
  },
  methods: {},
};
</script>

<style>
@import "./tailwind.css";
body {
  @apply bg-gray-900;
}
.flash {
  animation-name: flash;
  animation-duration: 1.5s;
  animation-iteration-count: 2;
}
@keyframes flash {
  from,
  50%,
  to {
    opacity: 1;
  }
  25%,
  75% {
    opacity: 0;
  }
}
</style>
