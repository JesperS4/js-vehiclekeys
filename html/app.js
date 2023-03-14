$(document).ready(() => {
    window.addEventListener("message", (event) => {
        let data = event.data 

        if (data.action == "open") {
            toggleKey(true)
        }
    })

    
})


$(() => {
    $('.image-opslot').click(function(e) {  
        $.post('https://prisma-vehiclekeys/closevehicle')
        toggleKey(false)
    });
    $('.image-trunk').click(function(e) {  
        $.post('https://prisma-vehiclekeys/opentrunk')
        toggleKey(false)

    });
    $('.image-open').click(function(e) {  
        $.post('https://prisma-vehiclekeys/openvehicle')
        toggleKey(false)

    });
})
    

$(document).on('keydown', function(event) {
    if (event.key == "Escape") {
        toggleKey(false)
    }
});


toggleKey = (bool) => {
    if (bool) {
        $('.image-container').show()
        $('.image-container').animate({'bottom': '1vh'}, 450)
    } else {
        $.post('https://prisma-vehiclekeys/close')
        $('.image-container').animate({'bottom': '-30vh'}, 450, function() {
            $('.image-container').hide()
        })
    }
}
