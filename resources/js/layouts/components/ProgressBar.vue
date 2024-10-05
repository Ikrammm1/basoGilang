<template>
    <div class="progress">
      <VProgressCircular
        :size="50"
        color="primary"
        indeterminate
      />
    </div>
  </template>
  
  <style>
  .progress {
    position: fixed;
    width: 100%;
    height: 100%;
    background-color: rgba(128, 128, 128, 0.3); /* Latar belakang dengan opasitas */
    display: flex; /* Memastikan konten berada di tengah */
    align-items: center; /* Vertikal center */
    justify-content: center; /* Horizontal center */
  }
  </style>
  