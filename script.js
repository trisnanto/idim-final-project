$(document).ready(function() {
  (async function() {
  
    $.ajax({
      url: 'data.php',
      method: 'GET',
      success: function(response) {
        let data = JSON.parse(response);
        console.log(data[1]);

        new Chart(
          document.getElementById('grafik1'),
          {
            type: 'pie',
            data: {
              labels: data[0].map(row => `${row.status_sekolah} : ${row.jumlah}`),
              datasets: [
                {
                  label: 'Jumlah PAUD',
                  data: data[0].map(row => row.jumlah),
                  hoverOffset: 4
                }
              ]
            },
          }
        );

        new Chart(
          document.getElementById('grafik5'),
          {
            type: 'pie',
            data: {
              labels: data[3].map(row => `${row.status_sekolah} : ${row.jumlah}`),
              datasets: [
                {
                  label: 'Jumlah PAUD',
                  data: data[3].map(row => row.jumlah),
                  hoverOffset: 4
                }
              ]
            },
          }
        );

        new Chart(
          document.getElementById('grafik6'),
          {
            type: 'pie',
            data: {
              labels: data[4].map(row => `${row.status_sekolah} : ${row.jumlah}`),
              datasets: [
                {
                  label: 'Jumlah PAUD',
                  data: data[4].map(row => row.jumlah),
                  hoverOffset: 4
                }
              ]
            },
          }
        );

        new Chart(
          document.getElementById('grafik2'),
          {
            type: 'bar',
            data: {
              labels: data[1].map(row => row.kecamatan),
              datasets: [
                {
                  label: 'PAUD',
                  data: data[1].map(row => row.jumlah_paud)
                },
                {
                  label: 'SD',
                  data: data[1].map(row => row.jumlah_sd)
                },
                {
                  label: 'SMP',
                  data: data[1].map(row => row.jumlah_smp)
                },
              ]
            }
          }
        );

        new Chart(
          document.getElementById('grafik3'),
          {
            type: 'line',
            data: {
              labels: data[2].map(row => row.kecamatan),
              datasets: [
                {
                  label: 'Jumlah Penduduk',
                  data: data[2].map(row => row.jumlah_penduduk),
                  yAxisID: 'y',
                },
                {
                  label: 'Kepadatan Penduduk',
                  data: data[2].map(row => row.kepadatan)
                },
                {
                  label: 'Luas Wilayah',
                  data: data[2].map(row => row.luas_wilayah),
                  yAxisID: 'y1',
                },
              ]
            },
            options: {
              responsive: true,
              interaction: {
                mode: 'index',
                intersect: false,
              },
              stacked: false,
              // plugins: {
              //   title: {
              //     display: true,
              //     text: 'Chart.js Line Chart - Multi Axis'
              //   }
              // },
              scales: {
                y: {
                  type: 'linear',
                  display: true,
                  position: 'left',
                },
                y1: {
                  type: 'linear',
                  display: true,
                  position: 'right',
          
                  // grid line settings
                  grid: {
                    drawOnChartArea: false, // only want the grid lines for one axis to show up
                  },
                },
              }
            },
          }
        );

        new Chart(
          document.getElementById('grafik4'),
          {
            type: 'line',
            data: {
              labels: data[2].map(row => row.kecamatan),
              datasets: [
                {
                  label: 'Jumlah Penduduk',
                  data: data[2].map(row => row.jumlah_penduduk),
                  yAxisID: 'y',
                },
                {
                  label: 'PAUD',
                  data: data[2].map(row => row.jumlah_paud),
                  yAxisID: 'y1',
                },
                {
                  label: 'SD',
                  data: data[2].map(row => row.jumlah_sd),
                  yAxisID: 'y1',
                },
                {
                  label: 'SMP',
                  data: data[2].map(row => row.jumlah_smp),
                  yAxisID: 'y1',
                },
              ]
            },
            options: {
              responsive: true,
              interaction: {
                mode: 'index',
                intersect: false,
              },
              stacked: false,
              scales: {
                y: {
                  type: 'linear',
                  display: true,
                  position: 'left',
                },
                y1: {
                  type: 'linear',
                  display: true,
                  position: 'right',
          
                  // grid line settings
                  grid: {
                    drawOnChartArea: false, // only want the grid lines for one axis to show up
                  },
                },
              }
            },
          }
        );
      },
    })
  })();
});