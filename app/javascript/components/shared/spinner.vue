<template>
  <div class="modal" :class="isShow ? 'is-active' : 'is-hidden'">
    <div class="modal-background"></div>
    <div class="modal-content">
      <div class="loader-wrapper">
        <div class="lds-ripple">
          <div></div>
          <div></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      isShow: false,
    };
  },
  methods: {
    showSpinner() {
      this.isShow = true;
    },
    hideSpinner() {
      this.isShow = false;
    },
  },
};
</script>

<style scoped>
.loader-wrapper {
  display: flex;
  align-items: center;
  overflow: hidden;
  margin: 0 auto;
  position: relative;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  flex-direction: column;
}
.lds-ripple {
  display: inline-block;
  position: relative;
  width: 160px;
  height: 160px;
}
.lds-ripple div {
  position: absolute;
  border: 4px solid #fff;
  opacity: 1;
  border-radius: 50%;
  animation: lds-ripple 1s cubic-bezier(0, 0.2, 0.8, 1) infinite;
}
.lds-ripple div:nth-child(2) {
  animation-delay: -0.5s;
}
@keyframes lds-ripple {
  0% {
    top: 72px;
    left: 72px;
    width: 0;
    height: 0;
    opacity: 1;
  }
  100% {
    top: 0px;
    left: 0px;
    width: 144px;
    height: 144px;
    opacity: 0;
  }
}
</style>
