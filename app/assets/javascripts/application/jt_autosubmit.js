;(function($){

    $.fn.jt_autosubmit = function(options) {

        if(!options){
            options = {};
        }

        var delay = 250;
        if(options && options.delay){
            delay = options.delay;
        }

        return this.each(function() {

            var context = {
                form: $(this),
                isSubmiting: false,
                needNewSubmit: false,
                timerId: null,
                delay: delay,
                disableOnInputEvent: options['disableOnInputEvent'],

                onLoading: options.onLoading,
                onComplete: options.onComplete,
            };

            // When the value of the input changed and the input lost focus
            context.form.on('change', 'input,select,textarea', function(){
                submit(context);
            });

            if(context.disableOnInputEvent !== true){
               // When the value of the input changed, but not fully supported by IE
                context.form.on('input', 'input,select,textarea', function(){
                    submit(context);
                });                
            }

            context.form.on('ajax:before', function(){
                return onSubmit(context);
            });

            context.form.on('ajax:complete', function(){
                onComplete(context);
            });

        });

        function submit(context){
            if(context.onLoading){
                context.onLoading.call(context.form);
            }

            if(context.timerId){
                clearInterval(context.timerId);
                context.timerId = null;
            }

            context.timerId = setTimeout(function(){
                context.timerId = null;
                context.form.submit();
            }, context.delay);
        }

        function onSubmit(context){
            if(context.isSubmiting){
                context.needNewSubmit = true;
                return false;
            }

            context.isSubmiting = true;
            return true;
        }

        function onComplete(context){
            context.isSubmiting = false;

            if(context.needNewSubmit){
                context.needNewSubmit = false;
                submit(context);
            }
            else{
                if(context.onComplete){
                    context.onComplete.call(context.form);
                }
            }
        }
    }

})(jQuery);
