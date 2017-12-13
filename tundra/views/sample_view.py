from django.views.generic import TemplateView
from tundra.tasks import sample_task


class SampleView(TemplateView):
    template_name = 'sample.html'

    def get(self, request, *args, **kwargs):
        return super(SampleView, self).get(request, *args, **kwargs)
